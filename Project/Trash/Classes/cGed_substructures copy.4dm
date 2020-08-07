/*  cGed_substructures ()
 Created by: Kirk as Designer, Created: 07/26/20, 09:11:39
 ------------------
 Purpose: this class manages breaking down text into a give substructure


*/

Class constructor
	
	This:C1470.data:=New collection:C1472  //  incoming text is parsed here
	
	This:C1470.regex:=prosObj.regex
	This:C1470.regex.setPattern("^(\\d+ )(@.+@ )?(\\w+ ?)(.+)?")
	This:C1470.OBJ:=prosObj.OBJ  //  
	This:C1470.str:=prosObj.str
	
	
Function parse  // (text|collection) -> tag object
	var $1 : Variant
	var $0,$TO : Object
	var $data : Collection
	
	Case of 
		: (Value type:C1509($1)=Is text:K8:3)
			$data:=Split string:C1554($1;"\r")
		: (Value type:C1509($1)=Is collection:K8:32)
			$data:=$1
		Else 
			TRACE:C157
	End case 
	
	$0:=This:C1470.getTO($data)
	
Function getTO  // (collection) -> TO (tag object)
	var $1,$levels_c,$level,$temp_c : Collection  //  may be a single element
	var $0,$TO,$o,$g,$bounds,$sub_o : Object
	
	$g:=This:C1470
	$o:=$g.__regex($1[0])
	
/*  Some tags are stored in collections
phones, email
*/
	
	Case of 
		: ($o.tag="PHON")
			
			
		Else 
			$TO:=New object:C1471
			$g.__mergeObj($o;$TO;New collection:C1472("value";"ptr";"xref"))
			
	End case 
	
	
	// --------------------------------------------------------
	If ($1.length>1)
		$temp_c:=$1.slice(1)  // all the other levels
		$levels_c:=This:C1470.__levelCol($temp_c)
		
		For each ($bounds;$levels_c)
			$level:=$temp_c.slice($bounds.a;$bounds.b)
			$o:=$g.__regex($level[0])
			
			Case of 
				: ($o.level=Null:C1517)  //  a CR within a text field 
					$TO.value:=$TO.value+"\r"+$level[0]
					
				: ($o.tag="CONT")
					Case of 
						: ($o.value=Null:C1517)
						: (Length:C16($o.value)=0)  //  nothing
						Else 
							$TO.value:=$TO.value+"\r"+$o.value
					End case 
					
				: ($o.tag="CONC")  // update the value in $TO
					Case of 
						: ($o.value=Null:C1517)
						: (Length:C16($o.value)=0)  //  nothing
						Else 
							$TO.value:=$TO.value+$o.value
					End case 
					
				Else 
					$sub_o:=New object:C1471
					$sub_o:=$g.getTO($level)
					$TO[$o.tag]:=$sub_o
					
			End case 
			
		End for each 
		
	End if 
	
	$0:=$TO
	
	
/* --------------------------------------------------------
  
  --------------------------------------------------------
*/
Function __regex  // (text) -> object
	var $1,$pattern,$value,$xref : Text
	var $0,$o,$reg : Object
	
	$reg:=This:C1470.regex
	
	$o:=New object:C1471(\
		"level";Null:C1517;\
		"tag";Null:C1517)
	
	If ($reg.find(1;$1))
		$o.level:=Num:C11($reg.getLastFind(1))
		If (This:C1470.str.trim($reg.getLastFind(2))#"")
			$o.xref:=This:C1470.str.trim($reg.getLastFind(2))
		End if 
		$o.tag:=This:C1470.str.trim($reg.getLastFind(3))
		$value:=This:C1470.str.trim($reg.getLastFind(4))
		
		Case of 
			: ($value="")
			: (Match regex:C1019("@\\w+@";$value;1))
				$o.ptr:=$value
			Else 
				$o.value:=$value
		End case 
		
	End if 
	
	$0:=$o
	
Function __levelCol  // (collection; index) -> col
/*  
return a collection of index values for level of $1[0]
*/
	var $1,$0,$col : Collection
	var $i,$k : Integer
	var $t,$line : Text
	var $col : Collection
	
	$col:=New collection:C1472()
	
	If ($1.length>0)
		$t:=Substring:C12($1[0];1;1)  // will be the level as a string
		$k:=0  // start of each level
		$i:=0  // 
		
		For each ($line;$1)
			Case of 
				: (Length:C16($line)=0)
					$1.remove($i)
					
				: ($line[[1]]=$t) & ($i>0)
					$col.push(New object:C1471("a";$k;"b";$i))
					$k:=$i
					$i:=$i+1
					
				Else 
					$i:=$i+1
					
			End case 
			
		End for each 
		
		$col.push(New object:C1471("a";$k;"b";$i))
	End if 
	
	$0:=$col
	
Function __levelBounds  // (collection; index) -> index
/* find the boundary of this level
return the index of the last element of this level
if there are no sub-levels return $2
*/
	var $1 : Collection
	var $2,$next,$i,$0 : Integer
	var $t,$line : Text
	
	$t:=Substring:C12($1[$2];1;1)  // will be the level as a string
	If ($1.length>($2+1))
		$next:=-1
		$i:=1+$2
		
		For each ($line;$1;$i) While ($next=-1)
			Case of 
				: ($line[[1]]=$t)
					$next:=$i-1
				: ($i=($1.length-1))
					$next:=$i
			End case 
			
			$i:=$i+1
		End for each 
		
	Else 
		$next:=$2
	End if 
	$0:=$next
	
Function __extractLevel  // (collection; index) -> collection 
	var $1,$0 : Collection
	var $2,$next : Integer
	
	$next:=This:C1470.__levelBounds($1;$2)
	$0:=$1.slice($2;$next)
	
Function __mergeObj  // (obj; obj{;col})
	var $1 : Object  //   source (to copy)
	var $2 : Object  //   target (copy to)
	var $3,$keys : Collection  //  specific key to merge
/* Purpose: merge keys in $1 into $2
  If $3 is defined only those non-null keys are passed
*/
	C_TEXT:C284($property)
	
	If (Count parameters:C259=3)
		$keys:=$3
	Else 
		$keys:=OB Keys:C1719($1)
	End if 
	
	For each ($property;$keys)
		
		If ($1[$property]#Null:C1517)
			
			Case of 
				: (Value type:C1509($1[$property])=Is collection:K8:32)
					$2[$property]:=$1[$property].copy()
					
				: (Value type:C1509($1[$property])=Is object:K8:27)
					$2[$property]:=OB Copy:C1225($1[$property])
					
				Else 
					$2[$property]:=$1[$property]
			End case 
			
		End if 
		
	End for each 