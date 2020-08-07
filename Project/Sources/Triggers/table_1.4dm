/*  Trigger on [GEDCOMS] ()
 Created by: Kirk as Designer, Created: 06/04/20, 17:11:02
 ------------------
 Purpose: 

*/



C_LONGINT:C283($0)
$0:=0  // Assume the database request will be granted

meta_update (->[GEDCOMS:1]d:3)

Case of 
	: (Test semaphore:C652("suppressTriggers"))
		  //  semaphore to set when doing bulk updates or other
		  //  operations where we don't want triggers to fire
		
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		
	: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		
End case 

