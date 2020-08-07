//%attributes = {}
/*  __readMe ()
 Created by: Kirk as Designer, Created: 05/30/20, 06:01:41
 ------------------
Build a component for parsing gedcoms




*/


ARRAY LONGINT:C221($aLen;0)
ARRAY LONGINT:C221($aPos;0)



var $fileFolder : Object
$fileFolder:=Folder:C1567(Folder:C1567(fk database folder:K87:14;*).path+"files/")

/* -- [ testing the class]

var $name_t : Text
var $name_o:Object

$name_t:="<Professor John (!Kirk) Kirkpatrick Brooks (Greene) Md. >JD Jr. dba Big Dreams LLC"
$name_t:="Brooks (Greene),<Professor =John (!Kirk) +Kirkpatrick  Md. >JD >\"Master at arms\" Jr. ~\"Bobby Joe\" ~Jimmy ~Jonny dba Big Dreams LLC"

$name_o:=cs.cName.new($name_t)

$text:=$name_o.getEncoded()

ALERT($name_o.name("!l;d"))
*/

/* -- [ parse list of tags into a hash map of tags ]

var $file_o : Object
var $lines_c,$temp_c : Collection
var $thisLine : Text

$file_o:=File($fileFolder.path+"tags.txt";fk posix path;*)

$lines_c:=Split string($file_o.getText(Document with CR);"\r")

◊tags:=New object()

For each ($thisLine;$lines_c)
$temp_c:=Split string($thisLine;"\t")

If ($temp_c.length=3)
◊tags[$temp_c[0]]:=New object("name";$temp_c[1];"desc";$temp_c[2])
End if 

End for each 
*/

// -- [ parse a  ged file ]
/*
//$file_o:=File($fileFolder.path+"JohnAndrews.ged";fk posix path;*)
$file_o:=File($fileFolder.path+"kBrooksFamFilewithSOUR.ged";fk posix path;*)

var $blob : Blob
$blob:=$file_o.getContent()
$text:=BLOB to text($blob;UTF8 text without length)
SET BLOB SIZE($blob;0)

//$text:=$file_o.getText(Document with CR)
// --------------------------------------------------------
//  build the hashmap
// --------------------------------------------------------
If (True)
$regEx_o:=cs.cRegex.new("0 @(\\w+)@ (\\w+)";True)  // ("@(\\w+)@";True)
$regEx_o.setText($text)
$n:=$regEx_o.findAll()
$id_col:=$regEx_o.extractFindAll(New collection(1))

//  build an object hashmap of the ids
$hashMap_o:=New object()

For each ($id_t;$id_col)

If ($hashMap_o[$id_t]=Null)
$hashMap_o[$id_t]:=New object("id";Substring($id_t;2))
End if 
End for each 
End if 

// --------------------------------------------------------
//  parse the file
// --------------------------------------------------------
// regex to split out the record string
$recRegX_c:=cs.cRegex.new("0 @(\\w+)@ (\\w+)")

$lines_c:=Split string($text;"\r")

// get the header record
$i:=0
$k:=$lines_c.findIndex($i+1;"util_find_1")  //  where next one
$this_rec_c:=$lines_c.slice(0;$k)

// --------------------------------------------------------
$i:=$k
Repeat 
$k:=$lines_c.findIndex($i+1;"util_find_1")  //  where next one

$this_rec_c:=$lines_c.slice($i;$k)


If ($recRegX_c.find(1;$this_rec_c[0]))


End if 


If ($k>0)
$i:=$k
End if 
Until ($k<0)


$i:=0
For each ($thisLine;$lines_c)


End for each 
*/


If (False:C215)
	var $TO;$o;$g : Object
	var $col : Collection
	
	$g:=cs:C1710.cGed_substructures.new()
	
	$col:=New collection:C1472(\
		"0 @I10@ INDI";\
		"1 NAME Wendy /Smith/";\
		"2 GIVN Wendy";\
		"1 SEX F";\
		"1 FAMS @F13@";\
		"1 RIN MH:I10";\
		"1 _UID C46459CAF0F443B39E4C2BA05B1655ED8D4C")
	
/* -- testing passing data into class
$text:="0 @I2@ INDI\r1 NAME Alvin J. /Carter/\r2 GIVN Alvin J.\r2 SURN Carter\r1 SEX M\r1 BIRT\r2 DATE Abt 1912\r2 PLAC Pierce Co. Georgia\r1 DEAT\r2 DATE 3 Jul 1961\r2 PLAC Tampa, Fl.\r1 _UID 3D3A2DD89DA3404C82B47C951034A5108830\r1 CHAN\r2 DATE 6 Nov 2007\r3 TIME 16:51\r1 FAMS @F1@\r1 FAMC @F2@"
$o:=$g.parse($text)
$o:=$g.parse($col)
*/
	
/* -- testing extracting from collection
$lines_c:=$g.__extractLevel($col;0)
$lines_c:=$g.__extractLevel($col;1)
$lines_c:=$g.__extractLevel($lines_c;1)
*/
	
/*  -- testing the level bounds function
$n:=$g.__levelBounds($col;0)
$n:=$g.__levelBounds($col;1)
$n:=$g.__levelBounds($col;3)
$levels_c:=$g.__levelCol($col.slice(7))
$temp_c:=$col.slice(0;1)
	
*/
	
/*
-- test .getTO
	
// $TO:=$g.getTO($g.__extractLevel($col;1))
*/
	
	// $col:=ds.Ged_rec.get("474AEBAC6C8841DC872383EEE3405037").d.data
	$col:=ds:C1482.GEDCOMS.get("9AAF8B008CC144E19DB0D88AF94A1B18").d.HEAD
	
	$TO:=New object:C1471()
	$g.getTO($col;$TO)
	
	
End if 


