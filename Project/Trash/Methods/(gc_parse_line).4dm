//%attributes = {}
/*  gc_parse_line (text)-> object
$1: gedcom line
$0: {level: 0, xref: "", tag: "", value:"", ptr: ""}
 Created by: Kirk as Designer, Created: 07/22/20, 17:52:38
 ------------------
 Purpose: 

*/

var $1,$pattern,$value : Text
var $0,$o,$reg,$str : Object

$reg:=prosObj.regex
$str:=prosObj.str

$o:=New object:C1471(\
"level";Null:C1517;\
"xref";Null:C1517;\
"tag";Null:C1517;\
"value";Null:C1517;\
"ptr";Null:C1517)

If ($reg.find(1;$1))
	$o.level:=Num:C11($reg.getLastFind(1))
	$o.xref:=$reg.getLastFind(2)
	$o.tag:=$reg.getLastFind(3)
	$value:=$reg.getLastFind(4)
	
	If (Match regex:C1019("@\\.+@";$value;1))
		$o.ptr:=$value
	Else 
		$o.value:=$value
	End if 
	
End if 

$0:=$o