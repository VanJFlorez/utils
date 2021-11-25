#SingleInstance,Force
CoordMode,Mouse,Screen

<^>!x::
	MouseGetPos,X,Y
	Msgbox, Your Cursor is at X: %X% Y: %Y%
<!F1::
	DllCall("SetCursorPos", int, -514, int, -28)
	return
<!F2::
	DllCall("SetCursorPos", int, 665, int, 397)
	return
<!F3::
	DllCall("SetCursorPos", int, 2265, int, 262)
	return
F1::return
	
<^>!Esc::ExitApp
