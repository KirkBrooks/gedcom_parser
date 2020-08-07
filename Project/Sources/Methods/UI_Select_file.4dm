//%attributes = {}
/*  UI_Select_file (obj) -> collection
$1: { path: "", types: "", message: "", options: 0 }
 Created by: Kirk as Designer, Created: 07/31/20, 07:30:35
 ------------------
 Purpose: choose a file or files

*/

var $1;$params : Object
var $0;$files_c : Collection
var $doc_name_t;$doc_type_t;$message_t;$default_path_t : Text
var $options_l;$i : Integer
ARRAY TEXT:C222($aDocs;0)

If (Count parameters:C259=1)
	$params:=$1
Else 
	$params:=New object:C1471
End if 

// defaults
$default_path_t:=""  //  Empty string to display default user folder (“My documents” under Windows, “Documents” under Mac OS),
$doc_type_t:="*"  //  .pdf;.jpg;.jpeg;.txt;.text;.csv;.json"
$message_t:="Select the document:"
$options_l:=Alias selection:K24:10+Use sheet window:K24:11

If ($params.path#Null:C1517)
	$default_path_t:=$params.path
End if 

If ($params.types#Null:C1517)
	$doc_type_t:=$params.types
End if 

If ($params.message#Null:C1517)
	$message_t:=$params.message
End if 

If ($params.options#Null:C1517)
	$options_l:=$params.options
End if 


// --------------------------------------------------------
$doc_name_t:=Select document:C905($default_path_t;$doc_type_t;$message_t;$options_l;$aDocs)

If (isOK)
	$files_c:=New collection:C1472
	For ($i;1;Size of array:C274($aDocs))
		$files_c.push(File:C1566($aDocs{$i};fk platform path:K87:2))
	End for 
End if 

// --------------------------------------------------------
$0:=$files_c
