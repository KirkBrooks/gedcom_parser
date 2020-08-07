//%attributes = {}
/*  GEDCOM_importer ()
 Created by: Kirk as Designer, Created: 06/04/20, 15:30:34
 ------------------
 Purpose: 

*/

C_LONGINT:C283($1)
C_LONGINT:C283($id;$i;$window)
C_TEXT:C284($procName)

$procName:=Current method name:C684

Case of 
	: (Count parameters:C259=0)
		$id:=Process number:C372($procName)
		
		If ($id=0)
			$id:=New process:C317(Current method name:C684;0;$procName;Current process:C322)
		Else 
			BRING TO FRONT:C326($id)
		End if 
		
	: (Count parameters:C259=1)  //     new process
		
		$window:=Open form window:C675([GEDCOMS:1];"gedcom_browser";Plain form window:K39:10)
		
		DIALOG:C40([GEDCOMS:1];"gedcom_browser")
		
		
End case 

