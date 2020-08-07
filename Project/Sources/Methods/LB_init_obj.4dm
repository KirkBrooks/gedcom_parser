//%attributes = {}
  //  LB_init_obj ({text{;longint}})
  // $1: list box object name
  // $2: window form is in
  // Written by: Kirk as Designer, Created: 03/07/20, 17:14:25
  // ------------------
  // Purpose: init a listbox object on Form
  // { name:        listbox object name
  //   data:        collection or entity selection 
  //   curItem:     currently selected item
  //   pos:         position (row) of selected item
  //   selected:    collection of selected items
  //   dataSource:  name of primary table (entity selections)
  //   queryStr:    query to establish .data
  //   config:      LB_config object
  // }
  //==========================================

C_TEXT:C284($1;$name)
C_LONGINT:C283($2;$window_l)
C_OBJECT:C1216($0;$lb_obj)

$window_l:=Current form window:C827
If (Count parameters:C259>0)
	$name:=$1
	If (Count parameters:C259>1)
		$window_l:=$2
	End if 
End if 

  // these have to do with the list box object on the form
$lb_obj:=New object:C1471(\
"data";Null:C1517;\
"curItem";Null:C1517;\
"pos";0;\
"selected";Null:C1517;\
"name";$name)
$lb_obj.parent_window:=$window_l  //  useful for updating a displayed listbox

  //  these properties can be edited 
$lb_obj.queryStr:=""  //  can be set to the listbox on load
$lb_obj.dataSource:=Null:C1517  // typically the table name an entity selection is based on

$lb_obj.config:=LB_init_configObj   // 

  // --------------------------------------------------------
$0:=$lb_obj