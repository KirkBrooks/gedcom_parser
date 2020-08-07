//  cLB ()
// Written by: Kirk as Designer, Created: 06/13/20, 21:41:14
// ------------------
// Purpose: 

// cLB ({text{;obj}}) -> obj
// $1: action
// $2: object referenced in an action
// $0: {msg":""}  | { meta format obj }
// Written by: Kirk as Designer, Created: 06/13/20, 21:41:18
// ------------------
// Purpose:
// initialize:  cLB("init")
// in a form:  $errMsg:=cLB ("add")
// also place in list box Text meta info expression

/*
C_TEXT($1;$errMsg;$lb_name;$text;$curPeriod_t)
C_OBJECT($2)
C_OBJECT($0)
C_COLLECTION($temp_c;$field_c)
C_LONGINT($i;$column;$row;$count;$WinRef)
C_OBJECT($o;$reg_o;$sect_o)

$lb_name:="**listboxname**"

If (Count parameters=0)  //  meta info expression object
If (This#Null)
$0:=Form[$lb_name].meta[0]
End if 

Else 

Case of 
: (Form=Null)
$errMsg:=("This only works when called in a form.")

: ($1="init")
Form[$lb_name]:=LB_init_obj($lb_name)

: ($1="load")
$temp_c:=New collection()  //  **some collection of entity selection**
Form.[$lb_name].data:=$temp_c.orderBy("")

: ($1="delete")

If (Form[$lb_name].curItem=Null)
$errMsg:="Click on a line first."
Else 
If (Form[$lb_name].delete=Null)  // if you want to cache changes for global accept/cancel
Form[$lb_name].delete:=New collection
End if 
$i:=Form[$lb_name].pos-1

Form[$lb_name].delete.push(Form[$lb_name].curItem)
Form[$lb_name].data.remove($i)
Form[$lb_name].data:=Form[$lb_name].data

Form[$lb_name].data.remove(Form[$lb_name].pos-1)
End if 

: ($1="add")
$o:=New object
Form.[$lb_name].data:=Form.[$lb_name].data

: ($1="edit")
$o:=Form[$lb_name].curItem
If ($o#Null)
$o.dirty:=True
**set some data**
End if 

: ($1="save")
For each ($o;Form[$lb_name].data)
Case of 
: ($o.dirty=Null)
: ($o.dirty=False)  //  you never know
Else   // update this record

If ($o.UUID=Null)  //  new record
$reg_o:=ds.**dataclass**.new()
Else 
$reg_o:=ds.**dataclass**.get($o.UUID)
End if 

// what can we really change here?
**do stuff**

If (Not(entity_save_1($reg_o)))  //  save and auto merge save
If (UI_confirm("Other changes have been made to record you are changing.\r\rDo you want to force your changes?";"";"Yes";"No"))
If (Not(entity_save_2($reg_o;New collection("field 1";"field 2";"field 3";"field 4"))))
ALERT("Your changes could not be forced. The record is probably locked on another computer.")
End if 
End if 
End if 

End case 

End for each 

// dropped records
If (Form[$lb_name].delete#Null)  // collection to be deleted
$temp_c:=Form[$lb_name].delete.extract("UUID")

$reg_o:=ds.**dataclass**.query(" UUID in :1";$temp_c)
$o:=$reg_o.drop()
$i:=$o.length

If ($i#0)  //The delete action is successful, all the entities have been deleted
ALERT(String($i)+" of the Records you attempted to delete could not be deleted.\r\rThe records are probably locked on another computer. ")
End if 
End if 
End case 

$0:=New object("msg";$errMsg)
End if 

*/