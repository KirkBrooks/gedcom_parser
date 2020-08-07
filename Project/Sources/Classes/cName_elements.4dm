/*  cName_elements ()
 Created by: Kirk as Designer, Created: 05/31/20, 21:47:32
 ------------------
 Purpose: functions that return lookup lists 
and other support for the name parser


*/

Class extends cStr

Class constructor
	  // Super()
	
	This:C1470.loadLists()
	  // This.str:=cs.cStr.new()
	
	
Function loadLists
	C_COLLECTION:C1488(<>prefixList;<>suffixList)
	C_OBJECT:C1216($path)
	$path:=File:C1566(Folder:C1567(fk resources folder:K87:11;*).platformPath+"prefixList.json")
	
	Case of 
		: (<>prefixList#Null:C1517)
		: ($path.exists=True:C214)
			<>prefixList:=JSON Parse:C1218($path.getText())
		Else 
			<>prefixList:=New collection:C1472("1st Lt";"Adm";"Atty";"Brother";"Capt";"Chief";"Cmdr";"Col";"Dean";"Dr";"Elder";"Father";"Gen";"Gov";"Hon";"Lt Col";"Maj";"MSgt";"Mr";"Mrs";"Ms";"Prince";"Prof";"Rabbi";"Rev";"Sister")
	End case 
	
	$path:=File:C1566(Folder:C1567(fk resources folder:K87:11;*).platformPath+"suffixList.json")
	
	Case of 
		: (<>suffixList#Null:C1517)
			
		: ($path.exists=True:C214)
			<>suffixList:=JSON Parse:C1218($path.getText())
		Else 
			<>suffixList:=New collection:C1472("II";"III";"IV";"CPA";"DDS";"Esq";"JD";"Jr";"LLD";"MD";"PhD";"Ret";"RN";"Sr";"DO")
	End case 
	
Function nameIsAlt  // (name) > bool
	  // $1: is a name string - best if a single name
	  // $0: true if string begins or ends with parens
	
	C_TEXT:C284($1)
	C_BOOLEAN:C305($0)
	
	Case of 
		: ($1="#@")
			$0:=True:C214
			
		: (Length:C16($1)<2)  //  we can still test for parens
			
		: ($1[[1]]="(")
			$0:=True:C214
			
		: ($1[[Length:C16($1)]]=")")
			$0:=True:C214
			
		Else 
			$0:=False:C215
	End case 
	
Function nameIsLastNameElement
	  // $1: a name
	  // $2: true to ignore alt spellings
	  // $0: true if it's commonly part of a last name
	  // Purpose: looks at the parsing rules 
	  // and also returns true parts of last names
	
	C_TEXT:C284($1)
	C_BOOLEAN:C305($2;$ignoreAlt)
	C_BOOLEAN:C305($0)
	
	If (Count parameters:C259=2)
		$ignoreAlt:=$2
	End if 
	
	Case of 
		: (Count parameters:C259=0)
			$0:=False:C215
		: ($1="")
			$0:=False:C215
		: (This:C1470.nameIsAlt($1))
			$0:=Not:C34($ignoreAlt)
			
		: (Position:C15("/";$1)>0)  //  part of a last name tag
			$0:=True:C214
			
		: (False:C215)  ////   
			
		: ($1="von")
			$0:=True:C214
			
		: ($1="de")
			$0:=True:C214
			
		: ($1="la")
			$0:=True:C214
			
		: ($1="del")
			$0:=True:C214
			
		: ($1="st") | ($1="st.")
			$0:=True:C214
			
	End case 
	
Function isPrefix  //  (word) -> bool
	C_TEXT:C284($1;$str)
	C_BOOLEAN:C305($0)
	$str:=Replace string:C233($1;".";"")
	
	$0:=<>prefixList.indexOf($str)>-1
	
Function isSuffix  //  (word) -> bool
	C_TEXT:C284($1;$str)
	C_BOOLEAN:C305($0)
	$str:=Replace string:C233($1;".";"")
	
	$0:=<>suffixList.indexOf($str)>-1
	