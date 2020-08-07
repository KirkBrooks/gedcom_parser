/*  cName ()
 Created by: Kirk as Designer, Created: 05/30/20, 16:45:02
 ------------------
 Purpose: 
/* 
The parts of a name can be explicitly identified in the input string. 
These identifiers may be mixed and matched. 
When explicit identifiers are used the order of the words does not matter. 

Explicit word idetifiers
 first name:    =John
 middle name:   +Margaret
 last name:     /Smith/  or  All words before,

 suffix:        >MD.
 prefix:        <Mr.
Prefixs and suffixs are also identified by comparison to lists. 


 preferred:     !Joe
 alias:         ~LuckyJoe
 dba:           dba Company Name  or [Company Name]

 alt:           (Smythe)  or #Smythe
Alts should be specified after the name type. 
  Bad:   /Smtih/ (Smythe)  
  Good:  /Smtih (Smythe)/  
  Good:  Smtih (Smythe), John (Johann)  
  Good:  =#Johann or =(Johann)
  Bad:   #=Johann or (=Johann)
If you use explicit identifiers for names they are used in order. 



Quoted strings
If a name, prefix or suffix has multiple words with spaces put it in double quotes: 
  "Mary Ellen"
  "Master at Arms"
Be sure to put identifiers OUTSIDE the double quotes
  +"Mary Ellen"  NOT "+Mary Ellen"

first, middle, last, prefix, suffix, and alias are lists. The first element of the list
is 'the' name. Alternates are included below. 

*/
*/
Class extends cName_elements

Class constructor  //  (input)
	Super:C1705()
	C_TEXT:C284($1)
	
	This:C1470.first:=New collection:C1472
	This:C1470.middle:=New collection:C1472
	This:C1470.last:=New collection:C1472
	This:C1470.prefix:=New collection:C1472
	This:C1470.suffix:=New collection:C1472
	This:C1470.dba:=""
	This:C1470.pref:=""
	This:C1470.alias:=New collection:C1472
	
	If (Count parameters:C259>0)
		This:C1470.parseNameStr($1)
		
	End if 
	
	  // --------------------------------------------------------
Function name  //  ( text ) -> text
	C_TEXT:C284($1;$t)
	C_TEXT:C284($0;$text_out)
	C_COLLECTION:C1488($temp_c)
	
	Case of 
		: (Count parameters:C259=0)  //  the default string
			$text_out:=This:C1470.get("last")+", "
			$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("first");This:C1470.get("middle"))
			
		: ($1="pref")
			$text_out:=This:C1470.concatWithStr(" ";This:C1470.get("pref");This:C1470.get("last"))
			
		: ($1="formal")
			$text_out:=This:C1470.concatWithStr(" ";This:C1470.get("prefix");This:C1470.get("first");This:C1470.get("middle");This:C1470.get("last");This:C1470.get("suffix"))
			
		: ($1="fml")
			$text_out:=This:C1470.concatWithStr(" ";This:C1470.get("first");This:C1470.get("middle");This:C1470.get("last"))
		Else 
			$temp_c:=Split string:C1554($1;"";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
			
			For each ($t;$temp_c)
				Case of 
					: ($t="f") | ($t="=")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("first"))
					: ($t="m") | ($t="+")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("middle"))
					: ($t="l")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("last"))
					: ($t="p") | ($t="<")  //   prefix
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("prefix"))
					: ($t="s") | ($t=">")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("suffix"))
					: ($t="!")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("pref"))
					: ($t="~")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("alias"))
					: ($t="d")
						$text_out:=This:C1470.concatWithStr(" ";$text_out;This:C1470.get("dba"))
					Else 
						$text_out:=$text_out+$t
				End case 
				
			End for each 
			
	End case 
	
	$0:=$text_out
	
Function get
	C_TEXT:C284($1)
	C_TEXT:C284($0)
	
	Case of 
		: ($1="pref") | ($1="dba")
			$0:=This:C1470[$1]
		: (This:C1470[$1].length>0)
			$0:=This:C1470[$1][0]
	End case 
	
Function getAll  //  
	
Function getEncoded  //
	C_TEXT:C284($0;$text_out;$thisField;$thisWord)
	C_LONGINT:C283($i)
	
	For each ($thisField;New collection:C1472("prefix";"first";"middle";"last";"suffix";"alias"))
		$i:=0
		For each ($thisWord;This:C1470[$thisField])
			If (Position:C15(" ";$thisWord)>0)
				$thisWord:="\""+$thisWord+"\""
			End if 
			
			Case of 
				: ($thisField="prefix")
					$thisWord:="<"+$thisWord
				: ($thisField="suffix")
					$thisWord:=">"+$thisWord
				: ($thisField="alias")
					$thisWord:="~"+$thisWord
				: ($i>0)
					$thisWord:="#"+$thisWord
			End case 
			
			$text_out:=This:C1470.concatWithStr(" ";$text_out;$thisWord)
			
			$i:=$i+1
		End for each 
	End for each 
	
	If (This:C1470.pref#"")
		$text_out:=This:C1470.concatWithStr(" ";$text_out;"!"+This:C1470.pref)
	End if 
	
	If (This:C1470.dba#"")
		$text_out:=This:C1470.concatWithStr(" ";$text_out;"["+This:C1470.dba+"]")
	End if 
	
	$0:=$text_out
	
Function getGedcom
	C_TEXT:C284($0;$text_out;$thisField;$thisWord)
	C_LONGINT:C283($i)
	C_BOOLEAN:C305($inLast)
	
	For each ($thisField;New collection:C1472("prefix";"first";"middle";"last";"suffix"))
		$i:=0
		
		For each ($thisWord;This:C1470[$thisField])
			If (Position:C15(" ";$thisWord)>0)
				$thisWord:="\""+$thisWord+"\""
			End if 
			
			If ($thisField#"last") & ($inLast)
				$inLast:=False:C215
				$thisWord:="/ "+$thisWord
			End if 
			
			Case of 
				: ($thisField="prefix")
					  //$thisWord:="<"+$thisWord
				: ($thisField="suffix")
					  //$thisWord:=">"+$thisWord
				: ($thisField="last") & ($inLast=False:C215)
					$inLast:=True:C214
					$thisWord:="/"+$thisWord
				: ($i>0)
					$thisWord:="("+$thisWord+")"
			End case 
			
			$text_out:=This:C1470.concatWithStr(" ";$text_out;$thisWord)
			
			$i:=$i+1
		End for each 
		
		If ($inLast)
			$inLast:=False:C215
			$text_out:=$text_out+"/"
		End if 
		
	End for each 
	
	$0:=$text_out
	
Function parseNameStr  // ( input string ) 
	C_TEXT:C284($1;$text_in)
	C_TEXT:C284($last_text;$trans_t;$thisWord;$str)
	C_BOOLEAN:C305($lastFirst;$inFirst;$inLast)
	C_LONGINT:C283($i)
	C_OBJECT:C1216($name_o)
	C_COLLECTION:C1488($temp_c)
	ARRAY LONGINT:C221($aPos;0)
	ARRAY LONGINT:C221($aLen;0)
	
	$text_in:=$1  //  "Brooks (Greene),<Professor =John (!Kirk) +Kirkpatrick  Md. >JD >\"Master at arms\" Jr. ~\"Bobby Joe\" ~Jimmy ~Jonny dba Big Dreams LLC"
	
	$name_o:=This:C1470
	
	  //  remove double spaces
	$text_in:=Replace string:C233($text_in;"  ";" ";*)
	$text_in:=Replace string:C233($text_in;"  ";" ";*)
	$lastFirst:=False:C215
	  // --------------------------------------------------------
	  //  extract a dba string
	  // --------------------------------------------------------
	Case of 
		: (Match regex:C1019(" ?\\[(.+)\\]";$text_in;1;$aPos;$aLen))  // square brackets
			$name_o.dba:=Substring:C12($text_in;$aPos{1};$aLen{1})  // omit the brackets
			$text_in:=Delete string:C232($text_in;$aPos{0};$aLen{0})
			
		: (Match regex:C1019("(?i) ?dba[ :.,]?(.+)";$text_in;1;$aPos;$aLen))  // dba string
			$name_o.dba:=Substring:C12($text_in;$aPos{1};$aLen{1})
			$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
			
	End case 
	
	  // --------------------------------------------------------
	  //  double quoted strings - replace spaces in the quoted strings with underscores - makes them a single word
	  // --------------------------------------------------------
	While (Match regex:C1019("\"([!\\w- ']+)\"";$text_in;1;$aPos;$aLen))
		$trans_t:=Substring:C12($text_in;$aPos{1};$aLen{1})  // omit the quotes
		$trans_t:=Replace string:C233($trans_t;" ";"_";*)
		$text_in:=Delete string:C232($text_in;$aPos{0};$aLen{0})
		$text_in:=Insert string:C231($text_in;$trans_t;$apos{0})
	End while 
	
	  // --------------------------------------------------------
	  //  extract explicit words
	  // --------------------------------------------------------
	
	  // alias
	While (Match regex:C1019("~([\\w-']+)";$text_in;1;$apos;$aLen))
		$name_o.alias.push(Replace string:C233(Substring:C12($text_in;$apos{1};$alen{1});"_";" "))
		$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
	End while 
	
	  // prefix
	While (Match regex:C1019("\\<([\\w-']+)";$text_in;1;$apos;$aLen))
		$name_o.prefix.push(Replace string:C233(Substring:C12($text_in;$apos{1};$alen{1});"_";" "))
		$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
	End while 
	
	  // suffix
	While (Match regex:C1019("\\>([\\w-']+)";$text_in;1;$apos;$aLen))
		$name_o.suffix.push(Replace string:C233(Substring:C12($text_in;$apos{1};$alen{1});"_";" "))
		$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
	End while 
	
	  // first name
	While (Match regex:C1019("\\=([\\w-']+)";$text_in;1;$apos;$aLen))
		$name_o.first.push(Replace string:C233(Substring:C12($text_in;$apos{1};$alen{1});"_";" "))
		$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
	End while 
	
	  // middle name
	While (Match regex:C1019("\\+([\\w-']+)";$text_in;1;$apos;$aLen))
		$name_o.middle.push(Replace string:C233(Substring:C12($text_in;$apos{1};$alen{1});"_";" "))
		$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
	End while 
	
	  // preferred
	While (Match regex:C1019("!([\\w-']+)";$text_in;1;$apos;$aLen))
		$name_o.pref:=Replace string:C233(Substring:C12($text_in;$apos{1};$alen{1});"_";" ")
		$text_in:=Delete string:C232($text_in;$apos{0};1)  // delete the !
	End while 
	
	  // --------------------------------------------------------
	  //  alts in parens - encode string 
	  // --------------------------------------------------------
	While (Match regex:C1019("\\(([\\w- ']+)\\)";$text_in;1;$aPos;$aLen))
		$trans_t:=Substring:C12($text_in;$aPos{1};$alen{1})  // omit the parens
		$trans_t:=" #"+Replace string:C233($trans_t;" ";"_";*)  // put space in front of # in case there are multiples: (one)(two)
		$text_in:=Delete string:C232($text_in;$aPos{0};$aLen{0})
		$text_in:=Insert string:C231($text_in;$trans_t;$aPos{0})
	End while 
	
	  // --------------------------------------------------------
	  //  is the txt last, first .... ?
	  // --------------------------------------------------------
	$last_text:=""
	If (Match regex:C1019("(.+), ";$text_in;1;$aPos;$aLen))
		$lastFirst:=True:C214
		$last_text:=Substring:C12($text_in;$apos{1};$alen{1})
		$text_in:=Delete string:C232($text_in;$apos{0};$alen{0})
	End if 
	
	  // --------------------------------------------------------
	  //  is the lastname enclosed in /.../ ?
	  // --------------------------------------------------------
	If (Match regex:C1019("\\/(.+)\\/";$text_in;1;$aPos;$aLen))
		
		If ($lastFirst)  //  already identified the lastname by comma
			
			
		Else 
			$last_text:=Substring:C12($text_in;$aPos{1};$aLen{1})
			$text_in:=Delete string:C232($text_in;$aPos{0};$aLen{0})
		End if 
		
	End if 
	
	  // --------------------------------------------------------
	
	$temp_c:=Split string:C1554($text_in;" ";sk ignore empty strings:K86:1+sk trim spaces:K86:2)  // split into words
	
	$thisWord:=""
	$text_in:=""
	
	  // --------------------------------------------------------
	  // check remaing words against prefix & suffix lists
	For each ($thisWord;$temp_c)
		
		Case of 
			: (This:C1470.isPrefix($thisWord))
				This:C1470.prefix.push($thisWord)
				
			: (This:C1470.isSuffix($thisWord))
				This:C1470.suffix.push($thisWord)
			Else 
				$text_in:=This:C1470.concatWithStr(" ";$text_in;$thisWord)
		End case 
		
	End for each 
	
	$temp_c:=Split string:C1554($text_in;" ";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	$text_in:=""
	
	If ($last_text="")  //  use word order to determine last name
		$inLast:=True:C214
		
		For each ($thisWord;$temp_c.reverse())  // reverse it 
			
			If ($inLast)
				$inLast:=$thisWord[[1]]="#"
				This:C1470.last.insert(0;This:C1470.stripEncode($thisWord))
			Else 
				$text_in:=This:C1470.concatWithStr(" ";$text_in;$thisWord)
			End if 
			
		End for each 
		
		$temp_c:=Split string:C1554($text_in;" ";sk ignore empty strings:K86:1+sk trim spaces:K86:2).reverse()
		
	End if 
	
	  // --------------------------------------------------------
	$inFirst:=True:C214
	
	$i:=0
	For each ($thisWord;$temp_c)
		If ($inFirst)
			$inFirst:=(($thisWord[[1]]="#") | ($i=0))  //  remain in first name while dealing with alts
		End if 
		
		
		If ($inFirst)
			This:C1470.first.push(This:C1470.stripEncode($thisWord))
		Else   //  middle name
			This:C1470.middle.push(This:C1470.stripEncode($thisWord))
		End if 
		
		
		$i:=$i+1
	End for each 
	
	  // now the last name
	$temp_c:=Split string:C1554($last_text;" ";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	For each ($thisWord;$temp_c)
		This:C1470.last.push(This:C1470.stripEncode($thisWord))
	End for each 
	
Function stripEncode  //  text - text
	C_TEXT:C284($1;$str;$0)
	$str:=$1
	
	Case of 
		: (Length:C16($str)=0)
		: ($str[[1]]="#") | ($str[[1]]="=") | ($str[[1]]="+") | ($str[[1]]="!") | ($str[[1]]="<") | ($str[[1]]=">") | ($str[[1]]="~")
			$str:=Substring:C12($str;2)
	End case 
	
	$0:=$str
	