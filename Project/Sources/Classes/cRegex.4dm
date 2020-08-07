/*  cRegex ()
 Created by: Kirk as Designer, Created: 05/30/20, 06:48:00
 ------------------
 Purpose: set a pattern to the class and use it to find instances
currently only supporting the case insensitive flag


*/

Class constructor  // (text: pattern; bool:case insensitive)
	C_TEXT:C284($1)
	C_BOOLEAN:C305($2)  //  case insensitive
	
	This:C1470.rg:=New object:C1471
	This:C1470.rg.pattern:=""
	This:C1470.rg.caseInsensitive:=False:C215
	This:C1470.rg.text:=Null:C1517
	
	
	If (Count parameters:C259>0)
		This:C1470.rg.pattern:=$1
	End if 
	
	If (Count parameters:C259>1)
		This:C1470.rg.caseInsensitive:=$2
	End if 
	
Function setText  //  set the text to operate on
	C_TEXT:C284($1)
	This:C1470.rg.text:=$1
	
Function setPattern  //  set $1 to the pattern
	C_TEXT:C284($1)
	This:C1470.rg.pattern:=$1
	
Function clear  //  clear text; lastFind; lastFindAll
	This:C1470.rg.text:=Null:C1517
	This:C1470.rg.lastFind:=Null:C1517
	This:C1470.rg.lastFindAll:=Null:C1517
	
Function caseSensitive  //  (bool)
	C_BOOLEAN:C305($1)
	This:C1470.rg.caseInsensitive:=$1
	
Function find  // (long:start; text:text; text:pattern)-> bool attempt to find the pattern in $1
	C_LONGINT:C283($1;$start;$i)
	C_TEXT:C284($2;$text;$3;$pattern)  // string to search
	C_BOOLEAN:C305($0)
	C_OBJECT:C1216($o)
	C_COLLECTION:C1488($temp_c)
	
	ARRAY LONGINT:C221($aPos;0)
	ARRAY LONGINT:C221($aLen;0)
	$temp_c:=New collection:C1472()
	
	$o:=New object:C1471("success";False:C215)
	
	If (Count parameters:C259>0)
		$start:=$1
	Else 
		$start:=1
	End if 
	
	If (Count parameters:C259>1)
		This:C1470.rg.text:=$2
	End if 
	
	If (Count parameters:C259>2)
		This:C1470.rg.pattern:=$3
	End if 
	
	$pattern:=This:C1470.rg.pattern
	This:C1470.rg.lastFind:=Null:C1517
	  // --------------------------------------------------------
	If (This:C1470.rg.text#Null:C1517)
		
		If (This:C1470.rg.caseInsensitive)
			$pattern:="(?i)"+$pattern
		End if 
		
		If (Match regex:C1019($pattern;This:C1470.rg.text;$start;$aPos;$aLen))
			$o.success:=True:C214
			ARRAY TO COLLECTION:C1563($temp_c;$aPos;"pos";$aLen;"len")
			$o.hit:=$temp_c
			$o.start:=$aPos{0}
			$o.len:=$aLen{0}
			$o.end:=$aPos{0}+$aLen{0}  // the next start index
		End if 
		
		  // save the found strings
		If ($o.success)
			$temp_c:=New collection:C1472
			
			For ($i;0;Size of array:C274($aPos))
				$temp_c.push(New object:C1471("str";Substring:C12(This:C1470.rg.text;$aPos{$i};$aLen{$i});"pos";$aPos{$i};"len";$aLen{$i}))
			End for 
			
			This:C1470.rg.lastFind:=New object:C1471("start";$o.start;"len";$o.len;"end";$o.end;"strings";$temp_c)
			
		End if 
		
	End if 
	
	$0:=$o.success
	
Function findAll  //  attempt to find all patterns in $1
	C_LONGINT:C283($1;$start)
	C_TEXT:C284($2;$text;$3;$pattern)  // string to search
	C_LONGINT:C283($0;$n)
	
	If (Count parameters:C259>0)
		$start:=$1
	Else 
		$start:=1
	End if 
	
	If (Count parameters:C259>1)
		This:C1470.rg.text:=$2
	End if 
	
	If (Count parameters:C259>2)
		This:C1470.rg.pattern:=$3
	End if 
	
	This:C1470.rg.lastFindAll:=Null:C1517
	
	While (This:C1470.find($start))
		If (This:C1470.rg.lastFindAll=Null:C1517)
			This:C1470.rg.lastFindAll:=New collection:C1472
		End if 
		
		This:C1470.rg.lastFindAll.push(OB Copy:C1225(This:C1470.rg.lastFind))
		
		$start:=This:C1470.rg.lastFind.end
		
		$n:=This:C1470.rg.lastFindAll.length
	End while 
	
	$0:=$n
	
Function replace  // ( replace str; start; text ) -> bool
	C_TEXT:C284($1;$replace;$newStr)  //   string to replace
	C_LONGINT:C283($2;$start;$i;$len;$pos)
	C_TEXT:C284($3)  // string to search
	C_BOOLEAN:C305($0)
	C_COLLECTION:C1488($strings)
	
	$replace:=$1
	
	If (Count parameters:C259>1)
		$start:=$2
	Else 
		$start:=1
	End if 
	
	If (Count parameters:C259>2)
		This:C1470.rg.text:=$3
	End if 
	
	If (This:C1470.find($start))
		$strings:=This:C1470.rg.lastFind.strings
		$newStr:=This:C1470.rg.placeholders($replace)
		
		This:C1470.rg.text:=Delete string:C232(This:C1470.rg.text;$strings[0].pos;$strings[0].len)
		This:C1470.rg.text:=Insert string:C231(This:C1470.rg.text;$newStr;$strings[0].pos)
		
		  //  need to alter lastFind to reflect this change in position
		This:C1470.rg.lastFind.end:=$strings[0].pos+Length:C16($newStr)
		  // $o.strings:=New collection($replace;"pos";$o.strings[0].pos;Length($replace))
		
		$0:=True:C214
	End if 
	
Function replaceAll  // ( replace str; start; text ) -> n
	C_TEXT:C284($1;$replace)  //   string to replace
	C_LONGINT:C283($2;$start)
	C_TEXT:C284($3;$text)  // string to search
	C_LONGINT:C283($0;$n)
	
	$replace:=$1
	
	If (Count parameters:C259>1)
		$start:=$2
	Else 
		$start:=1
	End if 
	
	If (Count parameters:C259>2)
		This:C1470.rg.text:=$3
	End if 
	
	$n:=0
	
	While (This:C1470.replace($replace;$start))
		$n:=$n+1
		$start:=This:C1470.rg.lastFind.end
	End while 
	
	$0:=$n
	
Function placeholders  // (replace str) -> text
	  // operates on lastFind - populate replace with referenced values then insert replace into text
	C_TEXT:C284($1;$0;$replace)
	C_COLLECTION:C1488($strings)
	C_LONGINT:C283($i;$pos;$len)
	
	$strings:=This:C1470.rg.lastFind.strings
	$replace:=$1
	
	If (Match regex:C1019("(?<!\\\\)\\$\\d";$replace;1))  //  matches a non-escaped $n
		  //  replace the placeholders with found text
		For ($i;0;$strings.length-1)
			
			  // loop through the find groups and update the relace string
			If (Match regex:C1019("(?<!\\\\)\\$"+String:C10($i);$replace;1;$pos;$len))
				$replace:=Delete string:C232($replace;$pos;$len)
				$replace:=Insert string:C231($replace;$strings[$i].str;$pos)
			End if 
			
		End for 
	End if 
	
	$0:=$replace
	
Function extractFindAll  // ({collection of indexs}) -> collection
	  // $1 is a collection of indexs of groups to return
	C_COLLECTION:C1488($1;$0;$temp_c)
	C_OBJECT:C1216($o;$new_o)
	C_TEXT:C284($newStr)
	C_LONGINT:C283($i)
	
	If (This:C1470.rg.lastFindAll#Null:C1517)
		$temp_c:=New collection:C1472
		
		Case of 
			: (Count parameters:C259=0)
				For each ($o;This:C1470.rg.lastFindAll)
					$temp_c.push($o.strings[0].str)
				End for each 
				
			: ($1.length=1)  //  only one value requested
				$i:=$1[0]
				
				For each ($o;This:C1470.rg.lastFindAll)
					$temp_c.push($o.strings[$i].str)
				End for each 
				
			Else 
				For each ($o;This:C1470.rg.lastFindAll)
					
					$new_o:=New object:C1471
					For each ($i;$1)
						$new_o["$"+String:C10($i)]:=$o.strings[$i].str
					End for each 
					
					$temp_c.push($new_o)
				End for each 
				
		End case 
		
	End if 
	
	$0:=$temp_c
	
Function getLastFind  //  ({long})
	C_LONGINT:C283($1;$i)
	C_TEXT:C284($0)
	
	If (Count parameters:C259>0)
		$i:=$1
	End if 
	
	Case of 
		: (This:C1470.rg.lastFind.strings=Null:C1517)
		: ((This:C1470.rg.lastFind.strings.length-1)<$i)
		Else 
			$0:=This:C1470.rg.lastFind.strings[$i].str
	End case 
	
Function getStrings  //  -> collection
	C_COLLECTION:C1488($0)
	$0:=This:C1470.rg.lastFind
	
Function findAllResults  // -> collection  {start:0, end:0}
	C_COLLECTION:C1488($0)
	$0:=This:C1470.rg.lastFindAll
	
Function findAllStart  // -> collection  start locations
	C_COLLECTION:C1488($0)
	$0:=This:C1470.rg.lastFindAll.extract("start")
	