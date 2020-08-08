//%attributes = {}
/*  gedcom_browser_controller ()
 Created by: Kirk as Designer, Created: 06/04/20, 15:40:32
 ------------------
 Purpose: 

*/

C_TEXT:C284($1;$action;$errMsg)
C_VARIANT:C1683($2)
C_TEXT:C284($doc_name_t;$doc_type_t;$message_t;$default_path_t)
C_LONGINT:C283($options_l)
C_LONGINT:C283($form_event;$i)
C_OBJECT:C1216($o;$file_o)
C_TEXT:C284($menu;$result_t;$Doc)

$action:=FORM Event:C1606.objectName
$form_event:=FORM Event:C1606.code

Case of 
	: (Count parameters:C259>0)
		$action:=$1
	: ($action="")
		$action:="formEvents"
End case 
// ------------------------------------------



// ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
	: ($action="btn_addGedCom")
		var $files : Collection
		$files:=UI_Select_file(New object:C1471("types";".txt;.ged;.text";"message";"Select a GEDCOM to import:";"options";Alias selection:K24:10+Multiple files:K24:7))
		
		If (isOK)
			For each ($file_o;$files)
				gc_import_file($file_o)
			End for each 
			
			Form:C1466.gcom_LB.data:=ds:C1482.GEDCOMS.all()
		End if 
		
	: ($action="btn_delGed")
		If (Form:C1466.gcom_LB.curItem#Null:C1517)
			CONFIRM:C162("Really delete this record?")
			If (isOK)
				Form:C1466.gcom_LB.curItem.drop()
				Form:C1466.gcom_LB.data:=ds:C1482.GEDCOMS.all()
			End if 
		End if 
		
	: (False:C215)  ///// fields /////
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form objects /////
	: ($action="gcom_LB")
		If (Form:C1466.gcom_LB.curItem#Null:C1517)
			Form:C1466.recs_LB.data:=Form:C1466.gcom_LB.curItem.Records
		Else 
			Form:C1466.recs_LB.data:=Null:C1517
		End if 
		
	: ($action="")
	: (False:C215)  ///// form actions /////
	: ($action="loadGEDS")
	: ($action="")
	: ($action="formEvents")
		Case of 
			: ($form_event=On Load:K2:1)
				Form:C1466.gcom_LB:=LB_init_obj("gcom_LB")
				Form:C1466.gcom_LB.data:=ds:C1482.GEDCOMS.all()
				
				Form:C1466.recs_LB:=LB_init_obj("recs_LB")
				
				
			: ($form_event=On Outside Call:K2:11)
				
				
				
		End case 
	Else 
		// $errMsg:="Unknown action: "+$action+"\ror Object: "+FORM Event.objectName+"\rForm Event: "+FORM Event.description+"  {"+Current method name+"}"
End case 

// ------------------------------------------
If ($errMsg#"")
	ALERT:C41($errMsg;Current method name:C684)
End if 
