//%attributes = {}
  //  meta_update (ptr)
  // $1: pointer to object field of a table
  // Written by: Kirk as Designer, Created: 03/31/20, 10:52:16
  // ------------------
  // Purpose: utility for updating the meta info - usually from a trigger
C_POINTER:C301($1)

Case of 
	: (Test semaphore:C652("suppressTriggers"))
	: ($1=Null:C1517)
	: (Type:C295($1->)#Is object:K8:27)  //  only valid for object fields
	Else 
		If ($1->=Null:C1517)
			$1->:=New object:C1471
		End if 
		
		C_OBJECT:C1216($o)
		$o:=$1->
		If ($o.meta=Null:C1517)
			$o.meta:=New object:C1471
		End if 
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				$o.meta.created:=New object:C1471("name";Current user:C182;"date";String:C10(Current date:C33;ISO date:K1:8;Current time:C178))
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ($o.meta.modified=Null:C1517)
					$o.meta.modified:=New object:C1471
				End if 
				
				If ($o.meta.modified.n=Null:C1517)
					$o.meta.modified.n:=0  //  count of number of changes
				End if 
				
				$o.meta.modified.name:=Current user:C182
				$o.meta.modified.date:=String:C10(Current date:C33;ISO date:K1:8;Current time:C178)
				$o.meta.modified.n:=$o.meta.modified.n+1
				
		End case 
End case 
