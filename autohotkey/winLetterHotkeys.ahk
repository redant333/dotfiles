#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
This script maps activation of different windows to Win+letter based
on the executable name.

Find the exe name with Window Spy from AutoHotkey tray right click menu.
*/
#F5::
Reload
return

#v::
WinActivate, ahk_exe code.exe
return

#c::
WinActivate, ahk_exe viber.exe
return

#b::
WinActivate, ahk_exe chrome.exe
return

Pause::
If WinActive("ahk_class ConsoleWindowClass")
    WinMinimize ahk_class ConsoleWindowClass
Else
    WinActivate ahk_class ConsoleWindowClass
