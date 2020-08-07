/*  [Ged_rec].indi_sm_dlog ()
 Created by: Kirk as Designer, Created: 07/27/20, 11:17:20
 ------------------
 Purpose: 

*/

Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		Form:C1466.e:=ds:C1482.Ged_rec.get([Ged_rec:2]id:1)
		
		
End case 

