//%attributes = {}
/*  gedcom__readMe ()
 Created by: Kirk as Designer, Created: 07/07/20, 11:15:44
 ------------------
 Purpose: this is a database of databases. Each Gedcom is a self contained database. Here we collect
any number of these databases. 

A GEDCOM data structure
Keep this simple and to the point. THe fancy stuff will come later the goal here is to represent the
GEDCOM data in a consistent way. Actually using that data more effectively is done elsewhere. 

/*
[INDIVIDUAL]

[FAMILY]

[NOTE]

[SOURCE]

[EVENT]



*/

Other data such as Submitter, Header, Submission are stored in the GEDCOM record.
*/

/* test parsing a gedcom line

prosObj.regex.setPattern("(\\d+ )(@.+@ )?(\\w+ ?)(.+)?")

// $text:="0 @1234@ INDI"
// $text:="1 AGE 13y"
// $text:="1 NOTE This is a note field that is"
$text:="1 CONT 33.       vii.       JOSEPH HENRY SCARBOROUGH, b. 03 December 1834, TN; d. 06 June 1893, Memphis, Shelby, Tennessee.\n"

$o:=gc_parse_line($text)
*/

/*  this is a method based approach to parsing the gedcom. 
we still use the idea of each record being split into a colleciton of lines
but the basic method will be:
( $1; $2; $3) 
$1: the object to append the new object to
$2: collection

purpose: parse the tag in $1[0], create a new object and add to $2 as
  $2[tag]:=new object

Contents will be value |  ptr | another tag (recursion)

gc_parse_level works so well I'm just going to use it for the entire import. 




*/

/*  this approach is based on methods instead of a monolithic class
  let's get some data
$text:=Get text from pasteboard
◊data_col:=Split string($text;"\n")
gc_parse_level($TO;<>data_col.copy())

C_OBJECT(<>TO)
var $TO;$file_o : Object
$TO:=New object()

$temp_c:=UI_Select_file(New object("types";".ged"))

If (isOK)
$file_o:=$temp_c[0]
$TO.file:=New object("name";$file_o.fullName;"path";$file_o.platformPath)

$text:=blob_to_text($file_o.getContent(()))
$text:=prosObj.str.fixLineEnding($text)

gc_parse_level($TO;Split string($text;"\r"))

End if 
*/

/* illustrates the data structure. 
Each record/tag is an object {value:"", ptr:"", xref:"", d:[]}
xref is only on a record
ptr  points to an xref
d    is collection of other data

$temp_c:=New collection

$o:=New object(\
"value";"John Smith";\
"d";New collection)
$o.d.push(New object("GIVN";New object("value";"John")))
$o.d.push(New object("SURN";New object("value";"Smith")))
$temp_c.push(New object("NAME";$o))

$o:=New object(\
"value";"James Smith";\
"d";New collection)
$o.d.push(New object("GIVN";New object("value";"James")))
$o.d.push(New object("SURN";New object("value";"Smith")))
$temp_c.push(New object("NAME";$o))

$o:=New object(\
"value";"John Brown";\
"d";New collection)
$o.d.push(New object("GIVN";New object("value";"John")))
$o.d.push(New object("SURN";New object("value";"Brown")))
$temp_c.push(New object("NAME";$o))


$o:=New object(\
"value";Current date)

$temp_c.push(New object("DATE";$o))
$c:=$temp_c.query("NAME.d[].SURN.value = :1 ";"smith")
*/

/* parsing the TO object
$this_rec:=<>TO.tags[0]
$temp_o:=$this_rec.tags.query("tag = :1";"FILE")
*/



