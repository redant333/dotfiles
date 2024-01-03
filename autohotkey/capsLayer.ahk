#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Notes                                                                      ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
; This file needs to be saved as UTF with BOM, otherwise åöä literals create
; problems.

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Caps layer handling functions                                              ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
global SHORT_PRESS_THRESHOLD_MS := 200
global gCapsDown := False
global gCapsPressTimestamp := 0
global gKeyPressedDuringCapsDown := False

CapsLock::
    if (not gCapsDown) {
        gCapsDown := True
        gKeyPressedDuringCapsDown := False
        gCapsPressTimestamp := A_TickCount
    }
Return

CapsLock Up::
    gCapsDown := False
    ; Treat the CapsLock press as usually if it's quick and no other keys
    ; have been pressed
    if (not gKeyPressedDuringCapsDown and A_TickCount - gCapsPressTimestamp < SHORT_PRESS_THRESHOLD_MS) {
        SetCapsLockState % !GetKeyState("CapsLock", "T")
    }
Return

SendUnderCaps(key) {
    Send {Blind}{%key%}
    gKeyPressedDuringCapsDown := True
}

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Bindings                                                                   ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

#If gCapsDown

f::Shift

*u::SendUnderCaps(1)
*i::SendUnderCaps(2)
*o::SendUnderCaps(3)
*j::SendUnderCaps(4)
*k::SendUnderCaps(5)
*l::SendUnderCaps(6)
*m::SendUnderCaps(7)
*,::SendUnderCaps(8)
*.::SendUnderCaps(9)
*/::SendUnderCaps(0)

[::SendUnderCaps("å")
+[::SendUnderCaps("Å")

'::SendUnderCaps("ä")
+'::SendUnderCaps("Ä")

; Semicolon is interpreted as start of comment, so use the SC code
SC027::SendUnderCaps("ö")
+SC027::SendUnderCaps("Ö")

#If

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Other                                                                      ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
;#F12::Reload ; Useful during development, should be commented out otherwise
