//%attributes = {}
  //  LB_config_showDlog (object{;long})
  // $1: LB_object  see:  LB_init_obj
  // $2: parent window id
  // Written by: Kirk as Designer, Created: 03/21/20, 11:50:52
  // ------------------
  // Purpose: 
  // Call from a form where the listbox is being displayed
  // if you pass $2, $34, & $4 you can update the listbox from the dialog

C_OBJECT:C1216($1;$form_obj)
C_LONGINT:C283($2;$window)


$form_obj:=New object:C1471
If (Count parameters:C259>1)
	$form_obj.parent_window:=$2
End if 
  // $1 is the lb_object 
$form_obj:=$1.config

$window:=Open form window:C675("lb_config_dlog";Plain form window:K39:10)
SET WINDOW TITLE:C213("Listbox Config for : "+$1.name)
DIALOG:C40("lb_config_dlog";$form_obj;*)

