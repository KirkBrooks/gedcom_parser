/*  cGedRec ()
 Created by: Kirk as Designer, Created: 07/23/20, 08:15:09
 ------------------
 Purpose: parse a collection of gedcom record lines into a record object
For the moment we're not worrying about what kind of record

 Level 0  = record id - already recorded
Level 1 = a field
              fields have a 'value' 
Level 1+ = something associate with that field

path  
/*
The path collection is the path for the current level
eg. path[0]  
    path[1]  NAME
    path[2]  NAME.GIVN
    path[3]  NAME.GIVN.SOUR  
*/

Level 1 TAGS
There can be multiple instances of level 1 tags - they are not unique within the record.
These will be stored in collections



*/
Class extends cGed_substructures

Class constructor
	
	This:C1470.data:=New collection:C1472()
	This:C1470.curLine:=Null:C1517  //  {level: 0, xref: "", tag: "", value:""}
	This:C1470.obj:=Null:C1517  //  the 
	This:C1470.path:=New collection:C1472("")
	
	
Function __parse
	var $thisLine;$path;$text : Text
	var $o;$thisField;$rec_o : Object
	var $curlevel : Integer
	
	$rec_o:=New object:C1471()  // build the gedcom record
	This:C1470.obj:=$rec_o
	$thisField:=Null:C1517
	$curlevel:=0
	$path:=""
	
	
	For each ($thisLine;This:C1470.data)
		$o:=This:C1470.__regex($thisLine)
		
		Case of 
			: ($o.level=0)
				$thisField:=Null:C1517
				
			: ($o.tag="CONT") | ($o.tag="CONC")
				// continue tag - add a new line
				$text:=""
				$text:=This:C1470.OBJ.getValue($rec_o;$path)
				
				If ($o.tag="CONT")
					$text:=$text+"\r"+$o.value
				Else 
					$text:=$text+$o.value
				End if 
				
				This:C1470.OBJ.setValue($rec_o;$path+".value";$text)
				
			: ($o.level=1)  //  a field | substructure
				
				$path:=This:C1470.__updatePath($o.tag;$o.level)
				This:C1470.__setValue($o;$path)
				$curlevel:=1
				
			: ($o.level=$curlevel)  //     another tag of the current level
				$path:=This:C1470.__updatePath($o.tag;$o.level)
				This:C1470.__setValue($o;$path)
				
			: ($o.level=($curlevel+1))  // new field  of $thisField
				$path:=This:C1470.__updatePath($o.tag;$o.level)
				This:C1470.__setValue($o;$path)
				$curlevel:=$curlevel+1
				
			Else 
				
				
		End case 
		
	End for each 
	
	This:C1470.obj:=$rec_o
	
Function __setValue  //  (level obj; path) 
	var $1;$o;$rec_o : Object
	var $2 : Text
	
	$o:=$1
	$rec_o:=This:C1470.obj
	
	Case of 
		: ($o.value#Null:C1517)
			This:C1470.OBJ.setValue($rec_o;$2+".value";$o.value)
		: ($o.ptr#Null:C1517)
			This:C1470.OBJ.setValue($rec_o;$2+".ptr";$o.ptr)
		Else 
			This:C1470.OBJ.setValue($rec_o;$2;New object:C1471)
	End case 
	
Function __updatePath  // (text; level)
	var $1;$t;$0;$path : Text
	var $2 : Integer
	var $temp : Collection
	
	// the collection can not be LONGER than $2
	$temp:=This:C1470.path.slice(0;$2)
	$temp[$2]:=$1
	
	$path:=""
	For each ($t;$temp;1;$2+1)
		$path:=This:C1470.str.concatWithStr(".";$path;$t)
	End for each 
	
	This:C1470.path:=$temp
	$0:=$path
	
Function __container  // (tag) -> 'prop' or 'col'
	var $1;$0 : Text
	var $cols : Collection
	
	$cols:=New collection:C1472("CAUS";"EDUC";"EMAIL";"EMIG";"EVEN";"FACT";"FAX";"GRAD";"IMMI";"NATI";"NATU";"OCCU";"PHON";"RESI";"SOUR")
	
	If ($cols.indexOf($1)>-1)
		$0:="col"
	Else 
		$0:="prop"
	End if 