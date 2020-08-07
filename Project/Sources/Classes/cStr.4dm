/*  cStr ()
 Created by: Kirk as Designer, Created: 05/30/20, 17:23:53
 ------------------
 Purpose: 



*/

// Class constructor


Function trim
	C_TEXT:C284($1;$0;$string)
	C_LONGINT:C283($pos;$len)
	
	ASSERT:C1129(Count parameters:C259#0)
	
	$string:=$1
	
	If (Length:C16($string)>0)
		
		If (Match regex:C1019("^\\s+";$string;1;$pos;$len))
			$string:=Substring:C12($string;$pos+$len)
		End if 
		
		If (Length:C16($string)>0)
			While (Position:C15($string[[Length:C16($string)]];"\r\n\t ")>0)
				$string:=Substring:C12($string;1;Length:C16($string)-1)
			End while 
			
			//  replace multiple spaces with singles
			While (Position:C15("  ";$string)>0)
				$string:=Replace string:C233($string;"  ";" ")
			End while 
			
		End if 
	End if 
	
	$0:=$string
	
Function concatWithStr  //   (text;Text;...)
	C_TEXT:C284($0;${1})  // all params are text
	C_LONGINT:C283($i)
	C_TEXT:C284($str;$delim)
	
	$delim:=$1
	
	For ($i;2;Count parameters:C259)
		Case of 
			: (Length:C16(${$i})=0)
			: (Length:C16($str)=0)
				$str:=${$i}
			Else 
				$str:=$str+$delim+${$i}
		End case 
	End for 
	
	$0:=$str
	
Function encodeQuotedText  //
	C_TEXT:C284($1;$0)
	C_BOOLEAN:C305($2;$replace)
	C_TEXT:C284($str;$text)
	C_LONGINT:C283($pos;$len)
	
	$str:=$1
	If (Count parameters:C259=2)
		$replace:=$2
	End if 
	
	// --------------------------------------------------------
	
	If ($replace)
		$str:=Replace string:C233($str;"_";" ")
		
	Else 
		While (Match regex:C1019("\".+?\"";$str;1;$pos;$len))  //  find text inside double quotes
			$text:=Replace string:C233(Substring:C12($str;$pos+1;$len-2);" ";"_")
			
			$str:=Delete string:C232($str;$pos;$len)
			$str:=Insert string:C231($str;$text;$pos)
		End while 
	End if 
	
	$0:=$str
	
Function padLeft
	C_TEXT:C284($1)
	C_LONGINT:C283($2;$n)
	C_TEXT:C284($3;$fill_t)
	C_TEXT:C284($0;$str)
	
	Case of 
		: (Count parameters:C259=0)
		: ($1="")
		: (Length:C16($1)>=$2)
			$str:=Substring:C12($1;1;$2)
		Else 
			
			If (Count parameters:C259=3)
				$fill_t:=$3
			Else 
				$fill_t:=" "
			End if 
			
			$n:=$2-Length:C16($1)
			
			$str:=($fill_t*$n)+$1
			
	End case 
	
	$0:=$str
	
Function fixLineEnding  //  change all to CR
	var $1;$0;$text : Text
	
	$text:=$1
	$text:=Replace string:C233($text;"\r\n";"\r")
	$text:=Replace string:C233($text;"\n";"\r")
	$text:=Replace string:C233($text;"\r\r";"\r")
	$0:=$text
	