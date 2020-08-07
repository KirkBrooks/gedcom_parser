//%attributes = {}
  // LB_apply_config (object)
  // $1: see:  LB_init_obj
  // Written by: Kirk as Designer, Created: 03/20/20, 14:19:50
  // ------------------
  // Purpose: object must have name and config
  // see:  LB_init_configObj

C_TEXT:C284($0;$errMsg)
C_OBJECT:C1216($1;$LB_obj;$this_o;$config_o)
C_TEXT:C284($name_t;$font_fam;$col_name)
C_LONGINT:C283($j)
C_POINTER:C301($nil)
C_COLLECTION:C1488($config_c)
C_LONGINT:C283($altBg_color;$stroke_color;$bg_color;$stroke_l;$bg_l;$altBg_l)

$LB_obj:=$1
$name_t:=$LB_obj.name
$config_o:=$LB_obj.config

LISTBOX DELETE COLUMN:C830(*;$name_t;1;LISTBOX Get number of columns:C831(*;$name_t))

  // --------------------------------------------------------
  //  GENERAL FORMAT
  // --------------------------------------------------------
LISTBOX SET ROWS HEIGHT:C835(*;$name_t;$config_o.rowHeight;lk pixels:K53:22)

  // default row colors
$stroke_color:=CSS_get_longFromName ($config_o.stroke)
$bg_color:=CSS_get_longFromName ($config_o.fill)
$altBg_color:=CSS_get_longFromName ($config_o.alternateFill)
  // OBJECT SET RGB COLORS(*;$name_t;$stroke_color;$bg_color;$altBg_color)

  //  gridlines
LISTBOX SET GRID:C841(*;$name_t;$config_o.grid_h;$config_o.grid_v)
LISTBOX SET GRID COLOR:C842(*;$name_t;CSS_get_longFromName ($config_o.horizontalLineStroke);True:C214;False:C215)
LISTBOX SET GRID COLOR:C842(*;$name_t;CSS_get_longFromName ($config_o.verticalLineStroke);False:C215;True:C214)

  //  default font settings
C_LONGINT:C283($font_size;$font_style;$text_align)
$font_fam:=$config_o.fontFamily
$font_size:=$config_o.fontSize
$font_style:=$config_o.fontStyle
$text_align:=$config_o.textAlign

LISTBOX SET HEADERS HEIGHT:C1143(*;$name_t;$config_o.headerHeight;lk pixels:K53:22)
LISTBOX SET FOOTERS HEIGHT:C1145(*;$name_t;$config_o.footerHeight;lk pixels:K53:22)

LISTBOX SET LOCKED COLUMNS:C1151(*;$name_t;$config_o.lockedColumnCount)
LISTBOX SET STATIC COLUMNS:C1153(*;$name_t;$config_o.staticColumnCount)

  // --------------------------------------------------------
  //  COLUMNS
  // --------------------------------------------------------
$config_c:=$config_o.columns

$j:=1  // next column
For each ($this_o;$config_c)
	$col_name:="col_"+String:C10($j)
	
	LISTBOX INSERT COLUMN FORMULA:C970(*;$name_t;\
		$j;\
		$col_name;\
		$this_o.dataSource;\
		$this_o.type;\
		"Hdr_"+String:C10($j);\
		$nil)
	
	OBJECT SET TITLE:C194(*;"Hdr_"+String:C10($j);$this_o.label)
	
	If ($this_o.width=Null:C1517)
		LISTBOX SET COLUMN WIDTH:C833(*;$col_name;100)
	Else 
		LISTBOX SET COLUMN WIDTH:C833(*;$col_name;$this_o.width)
	End if 
	
	If ($this_o.format#Null:C1517)
		OBJECT SET FORMAT:C236(*;$col_name;$this_o.format)
	End if 
	
	  // are there specific formats for this column?
	
	  // --------------------------------------------------------
	  // row colors
	If ($this_o.stroke=Null:C1517)
		$stroke_l:=$stroke_color
	Else 
		$stroke_l:=CSS_get_longFromName ($this_o.stroke)
	End if 
	
	If ($this_o.fill=Null:C1517)
		$bg_l:=$bg_color
	Else 
		$bg_l:=CSS_get_longFromName ($this_o.fill)
	End if 
	
	If ($this_o.alternateFill=Null:C1517)
		$altBg_l:=$altBg_color
	Else 
		$altBg_l:=CSS_get_longFromName ($this_o.alternateFill)
	End if 
	
	OBJECT SET RGB COLORS:C628(*;$col_name;$stroke_l;$bg_l;$altBg_l)
	
	  // --------------------------------------------------------
	If ($this_o.fontFamily=Null:C1517)
		OBJECT SET FONT:C164(*;$col_name;$font_fam)
	Else 
		OBJECT SET FONT:C164(*;$col_name;$this_o.fontFamily)
	End if 
	
	If ($this_o.fontSize=Null:C1517)
		OBJECT SET FONT SIZE:C165(*;$col_name;$font_size)
	Else 
		OBJECT SET FONT SIZE:C165(*;$col_name;$this_o.fontSize)
	End if 
	
	If ($this_o.fontStyle=Null:C1517)
		OBJECT SET FONT STYLE:C166(*;$col_name;$font_style)
	Else 
		OBJECT SET FONT STYLE:C166(*;$col_name;$this_o.fontStyle)
	End if 
	
	If ($this_o.textAlign=Null:C1517)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$col_name;$text_align)
	Else 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$col_name;textAlign_to_4Dconstant ($this_o.textAlign))
	End if 
	
	$j:=$j+1
End for each 

  // --------------------------------------------------------
$0:=$errMsg