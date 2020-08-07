//%attributes = {}
//  prosObj
// Written by: Kirk as KBrooks, Created: 11/06/18, 18:04:24
// ------------------
// Method: prosObj ()
// Purpose: return  prosObject

C_OBJECT:C1216(prosObject;$0;$obj)

If (prosObject=Null:C1517)
	
	prosObject:=New object:C1471(\
		"startedAt";Timestamp:C1445;\
		"window";New object:C1471)
	
	prosObject.process:=New object:C1471(\
		"number";Current process:C322;\
		"UUID";Lowercase:C14(Generate UUID:C1066))
	
	//  add some utility classes
	prosObject.regex:=cs:C1710.cRegex.new()
	prosObject.str:=cs:C1710.cStr.new()
	prosObject.OBJ:=cs:C1710.cObj.new()
	
	prosObject.g:=cs:C1710.cGed_substructures.new()
	
End if 

$0:=prosObject


