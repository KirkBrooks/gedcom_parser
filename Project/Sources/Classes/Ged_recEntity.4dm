Class extends Entity
/*
functions related to specific entity
*/

Function getBIRT  // -> text string of birth info
	var $0;$text : Text
	
	If (This:C1470.d.BIRT#Null:C1517)
		$text:=This:C1470.d.BIRT.DATE.value
		
	End if 
	$0:=$text
	
Function getNAME  // -> text 
	var $0;$text : Text
	
	If (This:C1470.d.NAME#Null:C1517)
		$text:=This:C1470.d.NAME.value
		
	End if 
	$0:=$text