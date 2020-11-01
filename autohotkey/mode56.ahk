#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
This script remaps SC056 (a key next to left Shift present on some layouts)
to a virtual modifier.
The modifier can act as hold modifier (like Shift) or toggle modifier (like CapsLock)
depending on if it was held or pressed. Holding it more than holdThresholdMs is interpreted
ass holding.

Hotkeys for this mode are listed in section that starts with:
	#If, (mode56Timestamp > 0)
*/
mode56Timestamp := 0
holdThresholdMs := 200

SC056::
	If (mode56Timestamp == 0) {
		mode56Timestamp := A_TickCount
	}
	ToolTip, % "`n   MODE56   `n ", 0, 0
	return

SC056 Up::
	elapsed := A_TickCount - mode56Timestamp
	If ( elapsed > holdThresholdMs) {
		mode56Timestamp := 0
		ToolTip
	}
	return

#If, (mode56Timestamp > 0)
	k::Up
	h::Left
	j::Down
	l::Right
#If
