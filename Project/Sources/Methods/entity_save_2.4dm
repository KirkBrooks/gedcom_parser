//%attributes = {}
  //  entity_save_2 (obj{;collection}) -> bool
  // $1: student class entity
  // $2: collection of attributes
  // $0: success
  // Written by: Kirk as Designer, Created: 06/01/20, 11:12:48
  // ------------------
  // Purpose: call this after entity_save_1
  // uses .clone() and .reload() to write the attributes changed


C_OBJECT:C1216($1;$entity;$o_status;$o_clone)
C_COLLECTION:C1488($2;$touchedAttributes)
C_BOOLEAN:C305($0;$ok)
C_TEXT:C284($this_attr)

$entity:=$1

Case of 
	: ($entity=Null:C1517)
	: (entity_save_1 ($entity))
		$ok:=True:C214
	: (Not:C34($entity.touched()) & Not:C34($entity.isNew()))
	Else 
		If (Count parameters:C259=2)
			$touchedAttributes:=$2
		Else 
			$touchedAttributes:=New collection:C1472
			$touchedAttributes:=$entity.touchedAttributes()
		End if 
		
		  //  clone and update
		$o_clone:=$entity.clone()
		$entity.reload()  //  update the entity from the database
		
		For each ($this_attr;$touchedAttributes)
			$entity[$this_attr]:=$o_clone[$this_attr]
		End for each 
		
		$ok:=entity_save_1 ($entity)
		
End case 
  // --------------------------------------------------------

$0:=$ok
