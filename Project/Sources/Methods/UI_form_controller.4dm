//%attributes = {}
/*  UI_outline_form_controller ()
   Written by: Kirk as Designer, Created: 10/30/19, 06:16:47
   ------------------
   Purpose: 
*/

C_TEXT:C284($1;$2;$action;$errMsg)
C_LONGINT:C283($0;$form_return)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj)
C_COLLECTION:C1488(import_data_col;$data_col)
C_TEXT:C284($this_subform;$menu)
C_LONGINT:C283($i)
/*
$ptrCurrent:=OBJECT Get pointer(Object current)
If (Count parameters=0)
$action:=OBJECT Get name(Object current)
Else 
$action:=$1
End if 
// ------------------------------------------
$obj:=New object
$data_col:=import_data_col
$this_subform:=Form.display_form


// ------------------------------------------
Case of 
: (False)  ///// buttons /////
: ($action="btn_next")
// what's next depends on where we are
Case of 
: ($this_subform="import_sub")  //  next is to parse it
If (dataCol_split_text(OBJECT Get pointer(Object named;"import_text";"subform"))>0)  // something got parsed
//  move on to the parser
$this_subform:="parser_sub"
Form.display_form:=$this_subform
UI_form_controller("display_form")

Else 
$errMsg:="Sorry, there doesn't seem to be anything to parse."
End if 

: ($this_subform="parser_sub")
// copy to clipboard or import to records
$menu:=$menu+"Copy to clipboard as JSON"

If (Get last table number>0)
$menu:=";---;Import to database..."
End if 

$i:=Pop up menu($menu)

Case of 
: ($i=1)  //  json


: ($i=3)  //  database

End case 

Else 
$errMsg:="Huh?"
End case 


: ($action="btn_back")

Case of 
: ($this_subform="parser_sub")  //  back to import
$this_subform:="import_sub"
Form.display_form:=$this_subform
UI_form_controller("display_form")


End case 

: ($action="")
: ($action="")
: (False)  ///// fields /////
: ($action="")
: ($action="")
: ($action="")
: ($action="")
: (False)  ///// form objects /////
: ($action="")
: ($action="")
: ($action="")
: ($action="")
: (False)  ///// form actions /////
: ($action="display_form")  //  set the subform to display

Form.subform:=Form[$this_subform]  //  set the data for the subform
OBJECT SET SUBFORM(*;"subform";$this_subform)  //  set the actual form
// the On load form event fires for the subform

: ($action="parse_form")

If ($data_col.length>0)
Form.subform:=Form.parser
OBJECT SET SUBFORM(*;"subform";"import_sub_2")
Else 
$errMsg:="There is no text to parse."
End if 

: ($action="map_form")


: ($action="")
: ($action="formEvents")
Case of 
: (Form event code=On Load)
// always start with the input form 
UI_form_controller("display_form")


: (Form event code=On Outside Call)
CANCEL
End case 
Else 
$errMsg:="Unknown action or object: "+$action+"\r\rForm Event: "+4D_FormEvent_text+"  {"+Current method name+"}"
End case 
// --------------------------------------------------------

OBJECT SET VISIBLE(*;"btn_back";$this_subform#"import_sub")

// ------------------------------------------
// $0:=$form_return
4D_ALERT($errMsg;Current method name)

*/