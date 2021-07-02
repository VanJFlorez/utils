#SingleInstance,Force
CoordMode,Mouse,Screen

<^>!x::
	MouseGetPos,X,Y
	Msgbox, Your Cursor is at X: %X% Y: %Y%
<^>!a::
	DllCall("SetCursorPos", int, -514, int, -28)
	return
<^>!s::
	DllCall("SetCursorPos", int, 665, int, 397)
	return
<^>!d::
	DllCall("SetCursorPos", int, 2265, int, 262)
	return
	
<^>!Esc::ExitApp
