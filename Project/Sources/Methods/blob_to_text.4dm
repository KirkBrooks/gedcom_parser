//%attributes = {}
/*  blob_to_text (blob) -> text
 Created by: Kirk as Designer, Created: 07/27/20, 10:19:47
 ------------------
 Purpose: deal with the various encodings

*/

C_BLOB:C604($1;$blob)
C_LONGINT:C283($expSize;$curSize;$compressed)
C_TEXT:C284($text)

$blob:=$1
BLOB PROPERTIES:C536($blob;$compressed;$expSize;$curSize)

If ($compressed#0)
	EXPAND BLOB:C535($blob)
End if 

$curSize:=BLOB size:C605($blob)
// --------------------------------------------------------

If ($curSize>0)
	$text:=Convert to text:C1012($blob;106)
	
	If (Length:C16($text)=0)
		$text:=Convert to text:C1012($blob;4)  //  MIBEnum
	End if 
	
End if 

// --------------------------------------------------------
$0:=$text
