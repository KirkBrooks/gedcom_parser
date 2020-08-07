//%attributes = {}
  //  LB_init_column (text; long; long{; text{;text}}) -> obj
  // $1: data source
  // $2: data type
  // $3: width
  // $4: header or column label
  // $5: format string
  // Written by: Kirk as Designer, Created: 03/21/20, 09:04:15
  // ------------------
  // Purpose: define the contents of a single column
  // other params can be defined:
  // $obj.fontFamily:="System Regular Font"
  // $obj.fontSize:=12  //           points
  // $obj.fontStyle:="normal"  //    normal|italic
  // $obj.stroke:="black"  //        font color
  // $obj.textAlign:="automatic"  // "automatic", "right", "center", "justify", "left"

C_TEXT:C284($1;$4;$5)
C_LONGINT:C283($2;$3)
C_OBJECT:C1216($0;$obj)

ASSERT:C1129(Count parameters:C259>=3;"Source, type and width parameters are required!")

$obj:=New object:C1471
$obj.dataSource:=$1
$obj.type:=$2
$obj.width:=$3

If (Count parameters:C259>3)
	$obj.label:=$4
Else 
	$obj.label:=""
End if 

If (Count parameters:C259>4)
	$obj.format:=$5
End if 

$obj.textAlign:="automatic"

$0:=$obj