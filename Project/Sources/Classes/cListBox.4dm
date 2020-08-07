//  cListBox ()
// Written by: Kirk as Designer, Created: 06/13/20, 21:41:40
// ------------------
// Purpose: from vdl
// class of functions that apply to any type of listbox

Class constructor
	C_TEXT:C284($1)
	C_OBJECT:C1216($o)
	
	$o:=This:C1470
	$o.name:=$1
	
	
Function getCoords
	C_OBJECT:C1216($0)
	C_LONGINT:C283($l;$t;$r;$b)
	OBJECT GET COORDINATES:C663(*;This:C1470.name;$l;$t;$r;$b)
	$0:=New object:C1471("width";$r-$l;"height";$b-$t;"left";$l;"right";$r;"top";$t;"bottom";$b)
	
Function setCoords  // (obj)
	var $1;$coords : Object
	var $prop : Text
	
	$coords:=This:C1470.getCoords()
	
	For each ($prop;$1)
		$coords[$prop]:=$1[$prop]
	End for each 
	
	OBJECT SET COORDINATES:C1248(*;This:C1470.name;$coords.left;$coords.top;$coords.right;$coords.bottom)
	
Function visible
	C_BOOLEAN:C305($0)
	$0:=OBJECT Get visible:C1075(*;This:C1470.name)
	
Function hide
	C_BOOLEAN:C305($1)
	OBJECT SET VISIBLE:C603(*;This:C1470.name;False:C215)
	
Function show
	C_BOOLEAN:C305($1)
	OBJECT SET VISIBLE:C603(*;This:C1470.name;True:C214)
	
Function nRows
	C_LONGINT:C283($0)
	$0:=LISTBOX Get number of rows:C915(*;This:C1470.name)
	
Function nColumns
	C_LONGINT:C283($0)
	$0:=LISTBOX Get number of columns:C831(*;This:C1470.name)
	
Function insertCol
/*  inserts a column appended to end if no column number
text by default
col name:  <lb name>_col_<#>
*/
	C_OBJECT:C1216($1)
	C_LONGINT:C283($j;$type)
	C_POINTER:C301($nil)
	C_TEXT:C284($datasource;$colName;$hdrName;$ftrName;$label;$uuid;$lb_name)
	
	$j:=1
	$type:=Is text:K8:3
	$datasource:=""
	$uuid:=Lowercase:C14(Substring:C12(Generate UUID:C1066;1;5))
	$colName:=This:C1470.name+"_col_"+$uuid
	$hdrName:=This:C1470.name+"_hdr_"+$uuid
	$label:="Column "+String:C10($j)
	
	If ($1.j#Null:C1517)
		$j:=$1.j
	End if 
	
	If ($1.type#Null:C1517)
		$type:=$1.type
	End if 
	
	If ($1.dataSource#Null:C1517)
		$datasource:=$1.dataSource
	End if 
	
	If ($1.label#Null:C1517)
		$label:=$1.label
	End if 
	
	If ($1.colName#Null:C1517)
		$colName:=$1.colName
	End if 
	
	If ($1.hdrName#Null:C1517)
		$hdrName:=$1.hdrName
	End if 
	
	If ($1.ftrName#Null:C1517)
		$ftrName:=$1.ftrName
	End if 
	
	// --------------------------------------------------------
	If ($ftrName="")
		LISTBOX INSERT COLUMN FORMULA:C970(*;$lb_name;\
			$j;\
			$colName;\
			$dataSource;\
			$type;\
			$hdrName;\
			$nil)
		
	Else 
		LISTBOX INSERT COLUMN FORMULA:C970(*;$lb_name;\
			$j;\
			$colName;\
			$dataSource;\
			$type;\
			$hdrName;\
			$nil;\
			$ftrName;\
			$nil)
		
	End if 
	
	
	OBJECT SET TITLE:C194(*;$hdrName;$label)
	
	If ($1.width#Null:C1517)
		LISTBOX SET COLUMN WIDTH:C833(*;$colName;$1.width)
	End if 
	
	If ($1.format#Null:C1517)
		OBJECT SET FORMAT:C236(*;$colName;$1.format)
	End if 
	
	If ($1.enterable#Null:C1517)
		OBJECT SET ENTERABLE:C238(*;$colName;$1.enterable)
	End if 
	
Function clearCols  //  delete all columns
	LISTBOX DELETE COLUMN:C830(*;This:C1470.name;1;LISTBOX Get number of columns:C831(*;This:C1470.name))
	
Function deleteColumn
	C_LONGINT:C283($1)
	LISTBOX DELETE COLUMN:C830(*;This:C1470.name;$1)
	
Function selectRow
	C_LONGINT:C283($1)
	LISTBOX SELECT ROW:C912(*;This:C1470.name;$1;lk replace selection:K53:1)
	OBJECT SET SCROLL POSITION:C906(*;This:C1470.name;$1)
	
Function getCell
	C_OBJECT:C1216($0;$o)
	C_LONGINT:C283($c;$r)
	LISTBOX GET CELL POSITION:C971(*;This:C1470.name;$c;$r)
	$0:=New object:C1471("row";$r;"column";$c)
	
	If ($c>0)
		$o:=This:C1470.colNames()
		$0.name:=$o.columns[$c-1]
	End if 
	
Function colNames  // -> obj
	C_OBJECT:C1216($0;$o)
	ARRAY BOOLEAN:C223($tBoo_ColsVisible;0x0000)
	ARRAY POINTER:C280($tPtr_ColVars;0x0000)
	ARRAY POINTER:C280($tPtr_FooterVars;0x0000)
	ARRAY POINTER:C280($tPtr_HeaderVars;0x0000)
	ARRAY POINTER:C280($tPtr_Styles;0x0000)
	ARRAY TEXT:C222($tTxt_ColNames;0x0000)
	ARRAY TEXT:C222($tTxt_FooterNames;0x0000)
	ARRAY TEXT:C222($tTxt_HeaderNames;0x0000)
	
	LISTBOX GET ARRAYS:C832(*;This:C1470.name;\
		$tTxt_ColNames;$tTxt_HeaderNames;\
		$tPtr_ColVars;$tPtr_HeaderVars;\
		$tBoo_ColsVisible;\
		$tPtr_Styles;\
		$tTxt_FooterNames;$tPtr_FooterVars)
	
	$o:=New object:C1471("definition";New collection:C1472)
	
	ARRAY TO COLLECTION:C1563($o.definition;\
		$tTxt_ColNames;"names";\
		$tTxt_HeaderNames;"headers";\
		$tTxt_FooterNames;"footers")
	
	$o.columns:=New collection:C1472
	
	var $i : Integer
	
	For ($i;1;Size of array:C274($tTxt_ColNames);1)
		$o.columns.push(New object:C1471("name";$tTxt_ColNames{$i};"number";$i;"pointer";$tPtr_ColVars{$i}))
	End for 
	
	This:C1470.d:=$o
	$0:=$o
	
	