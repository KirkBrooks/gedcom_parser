//%attributes = {}
/*  gc_make_records (object; text)
$1: record object
$2: id of gedcom record
 Created by: Kirk as Designer, Created: 07/06/20, 19:12:45
 ------------------
 Purpose: parse the blob into records

*/

var $1;$thisRec : Object
var $2 : Text
var $newRec : Object


If ($1#Null:C1517)
	$thisRec:=$1
	
	$newRec:=ds:C1482.Ged_rec.new()
	$newRec.sourceFile:=$2
	$newRec.kind:=$thisRec.tag
	$newRec.xref:=$thisRec.xref
	$newRec.value:=OB Get:C1224($thisRec;"value";Is text:K8:3)
	$newRec.d:=New object:C1471("tags";$thisRec.tags)
	
	entity_save_1($newRec)
	
End if 
