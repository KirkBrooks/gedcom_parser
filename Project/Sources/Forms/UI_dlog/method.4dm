  //  UI_dlog ()
  // Written by: Kirk as Designer, Created: 01/30/20, 15:13:40
  // ------------------
  // Purpose: 

C_OBJECT:C1216($file_obj)
C_LONGINT:C283($left;$top;$right;$bottom;$height;$width;$type;$padTop;$padLeft;$window)


Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*;"icon";Form:C1466.icon#"")
		
		If (Form:C1466.icon#"")
			C_TEXT:C284($icon_path;$svg)
			$icon_path:=Get 4D folder:C485(Current resources folder:K5:16)+Form:C1466.icon
			
			If (Test path name:C476($icon_path)=Is a document:K24:1)
				$svg:=DOM Parse XML source:C719($icon_path)
				OBJECT Get pointer:C1124(Object named:K67:5;"icon")->:=SVG_Export_to_picture ($svg)
				DOM CLOSE XML:C722($svg)
			End if 
			
		Else 
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			
			OBJECT SET COORDINATES:C1248(*;"message";10;10;$right-10;80)
			
		End if 
		
End case 
