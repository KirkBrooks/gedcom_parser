//%attributes = {}
  //  LB_config_dlog_controller ()
  // Written by: Kirk as Designer, Created: 03/21/20, 12:19:48
  // ------------------
  // Purpose: 
  // Form.lb_obj : see: LB_init_obj
  //    contains .config plus info about the specific listbox on the form
  // Form.config : see: LB_init_configObj
  //    contains the specifics about drawing the listbox irrespective of where it is
  // This dialog is only concerned with managing .config
  // It could be included as a subform on a dialog that manages the lb_obj

C_TEXT:C284($1;$2;$action;$errMsg)
C_LONGINT:C283($0;$form_return)
C_POINTER:C301($ptrCurrent;$ptrObj)
C_OBJECT:C1216($obj;$temp_o)
C_LONGINT:C283($column;$row;$i)
C_TEXT:C284($menu;$result;$text)
C_COLLECTION:C1488($temp_c)



$ptrCurrent:=OBJECT Get pointer:C1124(Object current:K67:2)
If (Count parameters:C259=0)
	$action:=OBJECT Get name:C1087(Object current:K67:2)
Else 
	$action:=$1
End if 
  // ------------------------------------------
$obj:=New object:C1471


  // ------------------------------------------
Case of 
	: (False:C215)  ///// buttons /////
	: ($action="btn_bgColor")
		$temp_o:=css_pick_color 
		If ($temp_o#Null:C1517)
			Form:C1466.fill:=$temp_o.hex
		End if 
		
	: ($action="btn_bgColor1")
		$temp_o:=css_pick_color 
		If ($temp_o#Null:C1517)
			Form:C1466.alternateFill:=$temp_o.hex
		End if 
		
	: ($action="btn_gridColor1")  // horiz
		$temp_o:=css_pick_color 
		If ($temp_o#Null:C1517)
			Form:C1466.horizontalLineStroke:=$temp_o.hex
		End if 
		
	: ($action="btn_gridColor2")  // vert
		$temp_o:=css_pick_color 
		If ($temp_o#Null:C1517)
			Form:C1466.verticalLineStroke:=$temp_o.hex
		End if 
		
	: ($action="btn_setFont")  //  
		$text:=Font_choose_byMenu 
		If ($text#"")
			Form:C1466.fontFamily:=$text
		End if 
	: ($action="btn_strokeColor")  //  
		$temp_o:=css_pick_color 
		If ($temp_o#Null:C1517)
			Form:C1466.stroke:=$temp_o.hex
		End if 
	: ($action="btn_fields")
		  // get fields
		$temp_c:=Struct_get_tableList 
		
		
		
		
	: ($action="btn_selectTable")
		
		
	: ($action="")
	: ($action="")
	: (False:C215)  ///// fields /////
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form objects /////
	: ($action="lb_cols")
		LISTBOX GET CELL POSITION:C971(*;$action;$column;$row)
		
		Case of 
			: (Form event code:C388=On Clicked:K2:4)
				Case of 
					: (($column=3) | ($column=4)) & (Contextual click:C713)
						$menu:="Text;Date;String;Longint;Real;Boolean"
						$i:=Pop up menu:C542($menu)
						If ($i>0)
							For each ($temp_o;Form:C1466[$action].selected)
								Case of 
									: ($i=1)
										$temp_o.type:=Is text:K8:3
									: ($i=2)
										$temp_o.type:=Is date:K8:7
									: ($i=3)
										$temp_o.type:=Is alpha field:K8:1
									: ($i=4)
										$temp_o.type:=Is longint:K8:6
									: ($i=5)
										$temp_o.type:=Is real:K8:4
									: ($i=6)
										$temp_o.type:=Is boolean:K8:9
								End case 
								
							End for each 
							Form:C1466[$action].data:=Form:C1466[$action].data
							
						End if 
						
						
						
						
				End case 
				
		End case 
		
		
	: ($action="")
	: ($action="")
	: ($action="")
	: (False:C215)  ///// form actions /////
	: ($action="")
	: ($action="")
	: ($action="")
	: ($action="")
	: ($action="formEvents")
		Case of 
			: (Form event code:C388=On Load:K2:1)
				Form:C1466.LB_fields:=LB_init_obj ("LB_fields")
				
			: (Form event code:C388=On Outside Call:K2:11)
				CANCEL:C270
		End case 
	Else 
		$errMsg:="Unknown action or object: "+$action  // +"\r\rForm Event: "+4D_FormEvent_text+"  {"+Current method name+"}"
End case 
  // --------------------------------------------------------
OBJECT Get pointer:C1124(Object named:K67:5;"bg_sample")->:=CSS_get_sample (Form:C1466.fill)
OBJECT Get pointer:C1124(Object named:K67:5;"bg_sample1")->:=CSS_get_sample (Form:C1466.alternateFill)
OBJECT Get pointer:C1124(Object named:K67:5;"grid_sample_1")->:=CSS_get_sample (Form:C1466.horizontalLineStroke)
OBJECT Get pointer:C1124(Object named:K67:5;"grid_sample_2")->:=CSS_get_sample (Form:C1466.verticalLineStroke)

OBJECT Get pointer:C1124(Object named:K67:5;"stroke_sample")->:=CSS_get_sample (Form:C1466.stroke)

  // ------------------------------------------
  // $0:=$form_return
UI_ALERT ($errMsg)

