//%attributes = {}
  //  LB_init_configObj ({text}) -> obj
  // $1: name
  // $0: config object
  // Written by: Kirk as Designer, Created: 03/21/20, 08:40:56
  // ------------------
  // Purpose: return an empty config object
  // all colors are CSS values - hex (#000000) or color name
  // note we don't care about the type of listbox here: could be entity or collection based
  // see:  LB_apply_config

C_TEXT:C284($1)
C_OBJECT:C1216($0;$config_o)

$config_o:=New object:C1471
$config_o.uuid:=Lowercase:C14(Generate UUID:C1066)
If (Count parameters:C259>0)
	$config_o.name:=$1
Else 
	$config_o.name:=""
End if 

$config_o.columns:=New collection:C1472

$config_o.rowHeight:=20

  // fill colors for rows
$config_o.fill:="white"
$config_o.alternateFill:="white"

  // gridlines
$config_o.grid_h:=True:C214
$config_o.grid_v:=True:C214
$config_o.horizontalLineStroke:="gray"
$config_o.verticalLineStroke:="gray"

  // footer & header heights
$config_o.footerHeight:=0  //  pix
$config_o.headerHeight:=22

  //
$config_o.lockedColumnCount:=0
$config_o.staticColumnCount:=0

  //  default size & font specs
$config_o.stroke:="black"  //        font color - also foreground color
$config_o.fontFamily:="System Regular Font"
$config_o.fontSize:=12  //           points
$config_o.fontStyle:=Plain:K14:1  //    normal|italic
$config_o.textAlign:=Align default:K42:1  // automatic, right, center, justify, left

  // --------------------------------------------------------
$0:=$config_o
