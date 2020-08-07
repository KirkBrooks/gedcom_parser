//%attributes = {}
  //  entity_save_1 () -> boo
  // $0: true if save works
  // Written by: Kirk as Designer, Created: 06/01/20, 16:22:50
  // ------------------
  // Purpose: attempt to save and then auto merge save

C_OBJECT:C1216($1;$entity;$o_status;$o_clone)
C_BOOLEAN:C305($0;$ok)

$entity:=$1

Case of 
	: ($entity=Null:C1517)
	Else   //  : ($entity.touched()) | ($entity.isNew())
		
		$o_status:=$entity.save()
		
		If ($o_status.success=False:C215)
			$o_status:=$entity.save(dk auto merge:K85:24)
		End if 
		
		$ok:=$o_status.success
		
End case 
  // --------------------------------------------------------
If ($ok)  //  because the trigger may have changed things
	$entity.reload()
End if 

$0:=$ok
