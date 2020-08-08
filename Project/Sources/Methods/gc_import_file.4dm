//%attributes = {}
/*  gc_import_file (obj) -> obj
$1: file obj
$0: gedcom entity
 Created by: Kirk as Designer, Created: 06/04/20, 16:51:26
 ------------------
 Purpose: check the database before hand


*/

C_OBJECT:C1216($1;$file_o;$0)
C_BLOB:C604($blob)
C_TEXT:C284($text;$id_t)
C_LONGINT:C283($i;$k;$n)
C_OBJECT:C1216($o;$hashMap_o;$TO;$reg)
C_COLLECTION:C1488($id_col;$lines_c;$recReg_c;$this_rec_c;$recs;$t)


$file_o:=$1
$reg:=prosObj.regex

$blob:=$file_o.getContent()

If (BLOB size:C605($blob)>0)
	$text:=Convert to text:C1012($blob;"UTF-8")
	// $text:=BLOB to text($blob;UTF8 text without length)
	
	If (Length:C16($text)=0)
		$text:=BLOB to text:C555($blob;Mac text without length:K22:10)
		
	End if 
	
Else 
	$text:=$file_o.getText()
End if 

// --------------------------------------------------------
//  build the hashmap
// --------------------------------------------------------
If (False:C215)
	//$regEx_o:=cs.cRegex.new(;True)  // ("@(\\w+)@";True)
	//$regEx_o.setText($text)
	$n:=$reg.findAll(1;$text;"0 @(\\w+)@ (\\w+)")
	$id_col:=$reg.extractFindAll(New collection:C1472(1))
	
	//  build an object hashmap of the ids
	$hashMap_o:=New object:C1471()
	
	For each ($id_t;$id_col)
		
		If ($hashMap_o[$id_t]=Null:C1517)
			$hashMap_o[$id_t]:=New object:C1471("id";Substring:C12($id_t;2))
		End if 
	End for each 
End if 

// --------------------------------------------------------
//  parse the file
// --------------------------------------------------------
$text:=prosObj.str.fixLineEnding($text)
$lines_c:=Split string:C1554($text;"\r")

$t:=Split string:C1554($lines_c[0];"")





$text:=""

$TO:=New object:C1471()
$TO.file:=New object:C1471("name";$file_o.fullName;"path";$file_o.platformPath)


gc_parse_level($TO;$lines_c)

CLEAR VARIABLE:C89($lines_c)

// --------------------------------------------------------
//  Create the GEDCOMS record
// can't include the blob with ORDA...
// --------------------------------------------------------
CREATE RECORD:C68([GEDCOMS:1])
[GEDCOMS:1]name:2:=$file_o.fullName
[GEDCOMS:1]blob:4:=$blob
[GEDCOMS:1]d:3:=New object:C1471(\
"filePath";$file_o.platformPath;\
"HEAD";$TO.tags[0])
SAVE RECORD:C53([GEDCOMS:1])

SET BLOB SIZE:C606($blob;0)

// --------------------------------------------------------
//  make the records
// --------------------------------------------------------
For each ($o;$TO.tags;1)
	gc_make_records($o;[GEDCOMS:1]id:1)
End for each 

UNLOAD RECORD:C212([GEDCOMS:1])
