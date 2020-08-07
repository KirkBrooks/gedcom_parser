//%attributes = {}
  // Method: OBJ_MERGE_KEYS (object; object{;bool})
  // $1: source (to copy)
  // $2: target (copy to)
  // $3: true to overwrite keys in $2
  // Purpose: merge keys in $1 into $2
  //  If $3 is False existing keys in $2 are not changed
  //  if $3 is TRUE all keys of $1 are written to $2
  // This only works on the top level of the object
  // ** any objects or collections in $1 are copied **

C_OBJECT:C1216($1;$2)
C_BOOLEAN:C305($3;$force)
C_TEXT:C284($property)

If (Count parameters:C259=3)
	$force:=$3
End if 

For each ($property;$1)
	
	If ($force) | ($2[$property]=Null:C1517)
		
		Case of 
			: (Value type:C1509($1[$property])=Is undefined:K8:13)
				  //  nothing
			: (Value type:C1509($1[$property])=Is collection:K8:32)
				$2[$property]:=$1[$property].copy()
				
			: (Value type:C1509($1[$property])=Is object:K8:27)
				$2[$property]:=OB Copy:C1225($1[$property])
				
			Else 
				$2[$property]:=$1[$property]
		End case 
		
	End if 
	
End for each 
