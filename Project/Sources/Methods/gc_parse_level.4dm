//%attributes = {}
/*  gc_parse_level ()
$1: the object to append the new object to
$2: record collection
 Created by: Kirk as Designer, Created: 07/30/20, 18:44:20
 ------------------
 Purpose: parse the collection of gedcom lines into a data object ($1)
works on all levels
Each tag except for CONC and CONT is parsed into a tag object
Tags are not unique at any level so all the tags for each level are pushed onto a collection
and the collection is added as $1.tags

CONT & CONC
These can be applied to any tag though they really only make sense to TEXT fields

Sometimes a record, usually a NOTE, will only have CONC & CONT tags. In this case the 
.value property is added and the text parsed into it. 

The purpose here is to parse the gedcom into a rational data structure that can be 
analyzed into our own data structure. It is searchable though the queries can get
pretty complicated

*/

var $1;$TO : Object
var $2;$col_in;$level_c;$tags;$bounds : Collection
var $i : Integer
var $o;$g;$tagBounds : Object
var $continue : Boolean
var $keyTag;$t : Text


$tags:=New collection:C1472
$col_in:=$2
$g:=prosObj.g

// --------------------------------------------------------
$bounds:=$g.__levelCol($col_in;1)  // all the level 1 tags

For each ($tagBounds;$bounds)
	$level_c:=$col_in.slice($tagBounds.a;$tagBounds.b)
	$o:=$g.__regex($level_c[0])
	
	$continue:=False:C215
	
	Case of 
		: ($o.tag=Null:C1517)
			$1.value:=$1.value+$level_c[0]
			
		: (($keyTag="CONT") | ($keyTag="CONC")) & ($o.tag#"CONT") & ($o.tag#"CONC")
			// changed from CONT/CONC to a new tag
			$tags.push($TO)
			
			$keyTag:=$o.tag  // a new tag
			$TO:=New object:C1471("tag";$keyTag)  //  tag object
			$g.__mergeObj($o;$TO;New collection:C1472("value";"ptr";"xref"))
			$continue:=True:C214
			
		: ($o.tag="CONT") & ($1.value#Null:C1517)  // continuation of this $1.value
			$1.value:=$1.value+"\r"+OB Get:C1224($o;"value";Is text:K8:3)
			
		: ($o.tag="CONC") & ($1.value#Null:C1517)
			$1.value:=$1.value+OB Get:C1224($o;"value";Is text:K8:3)
			
		: (($o.tag="CONT") | ($o.tag="CONC")) & ($TO=Null:C1517)  //  new
			$keyTag:=$o.tag
			$TO:=New object:C1471()
			$g.__mergeObj($o;$TO;New collection:C1472("value";"ptr";"xref"))
			
		: ($o.tag="CONT")
			$keyTag:=$o.tag
			If ($TO.value=Null:C1517)
				$TO.value:=OB Get:C1224($o;"value";Is text:K8:3)
			Else 
				$TO.value:=$TO.value+"\r"+OB Get:C1224($o;"value";Is text:K8:3)
			End if 
			
		: ($o.tag="CONC")
			$keyTag:=$o.tag
			If ($TO.value=Null:C1517)
				$TO.value:=OB Get:C1224($o;"value";Is text:K8:3)
			Else 
				$TO.value:=$TO.value+OB Get:C1224($o;"value";Is text:K8:3)
			End if 
			
		Else 
			$keyTag:=$o.tag
			$TO:=New object:C1471("tag";$keyTag)  //  tag object
			$g.__mergeObj($o;$TO;New collection:C1472("value";"ptr";"xref"))
			$continue:=True:C214
			
	End case 
	
	// --------------------------------------------------------
	$level_c:=$level_c.slice(1)
	
	Case of 
		: ($level_c.length=0)
		: ($TO=Null:C1517)
/*  this can happen when the text body contains tabs or other whitespace
 that confuse the parser. eg: some programs embed tables as \t \t \r
 add all to $1.value
*/
			For each ($t;$level_c)
				If ($o.tag="CONC")
					$1.value:=$1.value+$t
				Else   // CONT
					$1.value:=$1.value+"\r"+$t
				End if 
			End for each 
			
		Else 
			gc_parse_level($TO;$level_c.copy())
	End case 
	
	
	If ($continue)
		$tags.push($TO)
		$TO:=Null:C1517
		$keyTag:=""
	End if 
	
End for each 

// --------------------------------------------------------
If ($TO#Null:C1517)  // this would happen if we were CONT or CONC all of $2
	$tags.push($TO)
End if 

// --------------------------------------------------------
$1.tags:=$tags
