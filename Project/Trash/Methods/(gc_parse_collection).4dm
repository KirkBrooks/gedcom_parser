//%attributes = {}
/*  gc_parse_collection ()
$1: the object to append the new object to
$2: collection
 Created by: Kirk as Designer, Created: 07/30/20, 18:44:20
 ------------------
 Purpose:  parse the tag in $1[0], create a new object and add to $2 as
  $2[tag]:=new object

Contents will be value |  ptr | another tag (recursion)

CONT & CONC are not passed on but managed here

*/

var $1;$TO,$g; : Object
var $2;$col_int;$level_c : Collection
var $level;$i : Integer
var $o;$o_next : Object


$tags:=New collection:C1472
$col_in:=$2
$g:=prosObj.g

$o:=$g.__regex($col_in[0])
$level:=$o.level

// --------------------------------------------------------
$bounds:=$g.__levelCol($col_in;$level)  // all the level 1 tags

For each ($tagBounds;$bounds)
	$level_c:=$col_in.slice($tagBounds.a;$tagBounds.b)
	
	$o:=$g.__regex($level_c[0])
	$keyTag:=$o.tag
	
	Case of 
		: ($keyTag="CONC")
			Case of 
				: ($o.value=Null:C1517)
				: (Length:C16($o.value)=0)  //  nothing
				: ($TO.value=Null:C1517)
					$TO.value:=$o.value
				Else 
					$TO.value:=$TO.value+$o.value
			End case 
			
		: ($keyTag="CONT")
			Case of 
				: ($o.value=Null:C1517)
				: (Length:C16($o.value)=0)  //  nothing
				: ($TO.value=Null:C1517)
					$TO.value:=$o.value
				Else 
					$TO.value:=$TO.value+"\r"+$o.value
			End case 
			
		Else 
			$TO:=New object:C1471("tag";$keyTag)  //  tag object
			$g.__mergeObj($o;$TO;New collection:C1472("value";"ptr";"xref"))
	End case 
	
	// --------------------------------------------------------
	$level_c:=$level_c.slice(1)
	
	If ($level_c.length>0)
		gc_parse_collection($TO;$level_c.copy())
	End if 
	
	$tags.push($TO)
End for each 

$1.tags:=$tags

