//%attributes = {}
  //  gedcom_LB ()
  // Written by: Kirk as Designer, Created: 06/18/20, 15:16:11
  // ------------------
  // Purpose: 

C_TEXT:C284($1)
C_OBJECT:C1216($0;$o)
C_TEXT:C284($lb_name)

$lb_name:=Current method name:C684

Case of 
	: (Form:C1466=Null:C1517)
		
	: (Count parameters:C259=0)
		
	: ($1="init")
		$o:=New object:C1471
		$o.name:=$lb_name
		$o.data:=Null:C1517
		$o.curItem:=Null:C1517
		$o.selected:=Null:C1517
		$o.pos:=0
		$o.meta:=New collection:C1472(New object:C1471(\
			"stroke";"#000000";\
			"fontStyle";"normal";\
			"fontWeight";"normal";\
			"textDecoration";"normal"))
		Form:C1466[$lb_name]:=$o
		
		gedcom_LB ("load")
		
	Else 
		$o:=Form:C1466[$lb_name]
		
		Case of 
			: ($1="load")
				$o.data:=ds:C1482.GEDCOMS.all().orderBy(" name asc")
				
		End case 
		
End case 

