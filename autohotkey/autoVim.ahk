#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Notes                                                                      ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
; Many places are using double {Home} to make sure movement to the proper
; home position in VSCode where Home moves to the end of indentation.
; 
; Marking of lines in VISUAL LINE mode works correctly only in the first chosen
; direction either above or below the initial line. If the direction is changed
; during marking, there will be problems with selecting the initial line. This
; is not ideal, but it should be enough for the moment.

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Configuration constants                                                    ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
global SHORT_PRESS_THRESHOLD_MS := 200

global INDICATOR_X := 0
global INDICATOR_Y := 0
global INDICATOR_WIDTH := 1920
global INDICATOR_HEIGHT := 40

global INDICATOR_FONT_FAMILY := "Consolas"
global INDICATOR_FONT_SIZE := 14

global INDICATOR_NORMAL_BACKGROUND := "934B00"
global INDICATOR_NORMAL_FOREGROUND := "White"
global INDICATOR_NORMAL_TEXT := "NORMAL"

global INDICATOR_VISUAL_BACKGROUND := "2541B2"
global INDICATOR_VISUAL_FOREGROUND := "White"
global INDICATOR_VISUAL_TEXT := "VISUAL"

global INDICATOR_VISUAL_LINE_BACKGROUND := "963484"
global INDICATOR_VISUAL_LINE_FOREGROUND := "White"
global INDICATOR_VISUAL_LINE_TEXT := "VISUAL LINE"

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Global state and indicator handling                                        ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
global MODE_INSERT := 0
global MODE_NORMAL := 1
global MODE_VISUAL := 2
global MODE_VISUAL_LINE := 3

global VISUAL_LINE_UNSET := 0
global VISUAL_LINE_UP := 1
global VISUAL_LINE_DOWN := 2

global gVimMode := MODE_INSERT
global gIndicatorMode := MODE_INSERT
global gIndicatorLabel

global gNormalModeBuffer := ""
global gVisualLineModeDirection := VISUAL_LINE_UNSET

SetVimMode(mode) {
    if (mode == MODE_NORMAL) {
        gNormalModeBuffer := ""
    } else if (mode == MODE_VISUAL_LINE) {
        Send {Home}{Home}+{End}
        gVisualLineModeDirection := VISUAL_LINE_UNSET
    }

    gVimMode := mode
    RefreshIndicator()
}

SetNormalModeBuffer(newBuffer) {
    gNormalModeBuffer := newBuffer
    RefreshIndicator()
}

AppendNormalModeBuffer(textToAppend) {
    gNormalModeBuffer .= textToAppend
    RefreshIndicator()
}

RefreshIndicator() {
    indicatorMode := gIndicatorMode
    gIndicatorMode := gVimMode

    if(gVimMode == MODE_NORMAL and indicatorMode == MODE_NORMAL) {
        GuiControl,, gIndicatorLabel, %INDICATOR_NORMAL_TEXT% %gNormalModeBuffer%
        Return
    }

    Gui, Destroy

    if(gVimMode == MODE_INSERT) {
        Return
    }

    Gui, +AlwaysOnTop -Caption +ToolWindow

    if(gVimMode == MODE_NORMAL) {
        Gui, Font, s%INDICATOR_FONT_SIZE% c%INDICATOR_NORMAL_FOREGROUND%, %INDICATOR_FONT_FAMILY%
        Gui, Color, %INDICATOR_NORMAL_BACKGROUND%
        Gui, Add, Text, vgIndicatorLabel w%INDICATOR_WIDTH%, %INDICATOR_NORMAL_TEXT%
    } else if(gVimMode == MODE_VISUAL) {
        Gui, Font, s%INDICATOR_FONT_SIZE% c%INDICATOR_VISUAL_FOREGROUND%, %INDICATOR_FONT_FAMILY%
        Gui, Color, %INDICATOR_VISUAL_BACKGROUND%
        Gui, Add, Text, vgIndicatorLabel w%INDICATOR_WIDTH%, %INDICATOR_VISUAL_TEXT%
    } else if(gVimMode == MODE_VISUAL_LINE) {
        Gui, Font, s%INDICATOR_FONT_SIZE% c%INDICATOR_VISUAL_LINE_FOREGROUND%, %INDICATOR_FONT_FAMILY%
        Gui, Color, %INDICATOR_VISUAL_LINE_BACKGROUND%
        Gui, Add, Text, vgIndicatorLabel w%INDICATOR_WIDTH%, %INDICATOR_VISUAL_LINE_TEXT%
    }

    Gui, Show, NoActivate x%INDICATOR_X% y%INDICATOR_Y% w%INDICATOR_WIDTH% h%INDICATOR_HEIGHT%
}

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Handling of entering and exiting Vim mode via key SC056                    ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
global gVimModeEnterTimestamp := 0
global gHotkeyDown := False

SC056::
    if(gHotkeyDown) {
        Return
    }

    if (gVimMode == MODE_INSERT) {
        gVimModeEnterTimestamp := A_TickCount
        SetVimMode(MODE_NORMAL)
    } else {
        SetVimMode(MODE_INSERT)
    }

    gHotkeyDown := True
Return

SC056 Up::
    if(not gHotkeyDown) {
        Return
    }

    elapsed := A_TickCount - gVimModeEnterTimestamp
    if ( elapsed > SHORT_PRESS_THRESHOLD_MS and gVimMode == MODE_NORMAL) {
        SetVimMode(MODE_INSERT)
        gVimModeEnterTimestamp := 0
    }
    gHotkeyDown := False
Return

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ NORMAL mode                                                                ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

; NORMAL mode, empty buffer
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#If gVimMode == MODE_NORMAL and gNormalModeBuffer == ""

; Mode changes
i::SetVimMode(MODE_INSERT)
v::SetVimMode(MODE_VISUAL)
+v::SetVimMode(MODE_VISUAL_LINE)

; Movement
0::Home
$::Send {End}
+g::Send ^{End}
g::SetNormalModeBuffer("g")

w::^Right
b::^Left

k::Up
h::Left
j::Down
l::Right

; More inputs expected
d::SetNormalModeBuffer("d")
c::SetNormalModeBuffer("c")
y::SetNormalModeBuffer("y")

; Other
o::Send {End}{Enter}
+o::Send {Home}{Home}{Enter}{Up}
x::Delete
u::^z
p::^v

; NORMAL mode, [d]eleting
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#If gVimMode == MODE_NORMAL and gNormalModeBuffer == "d"

d::
    Send {Down}{Home}{Home}+{Up}{Delete}
    SetNormalModeBuffer("")
Return

0::
    SetNormalModeBuffer("")
    Send +{Home}{Delete}
Return

; NORMAL mode, [g]oing
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#If gVimMode == MODE_NORMAL and gNormalModeBuffer == "g"

g::
    SetNormalModeBuffer("")
    Send ^{Home}
Return

; NORMAL mode, [c]hanging
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#If gVimMode == MODE_NORMAL and gNormalModeBuffer == "c"

c::
    SetNormalModeBuffer("")
    Send {Home}+{End}{Delete}
    SetVimMode(MODE_INSERT)
Return

+g::
    SetNormalModeBuffer("")
    Send {Home}+^{End}{Delete}
    SetVimMode(MODE_INSERT)
Return

g::AppendNormalModeBuffer("g")

#If gVimMode == MODE_NORMAL and gNormalModeBuffer == "cg"

g::
    SetNormalModeBuffer("")
    Send {End}+^{Home}{Delete}
    SetVimMode(MODE_INSERT)

; NORMAL mode, [y]anking
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#If gVimMode == MODE_NORMAL and gNormalModeBuffer == "y"

y::
    SetNormalModeBuffer("")
    Send {Home}{Home}+{End}^c{End}
Return

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ VISUAL mode                                                                ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
#If gVimMode == MODE_VISUAL

; Mode changes
i::SetVimMode(MODE_INSERT)
+v::SetVimMode(MODE_VISUAL_LINE)
Esc::SetVimMode(MODE_NORMAL)

; Movement
0::Send, +{Home}
$::Send, +{End}

w::+^Right
b::+^Left

k::+Up
h::+Left
j::+Down
l::+Right

; Other
c::
    Send {Delete}
    SetVimMode(MODE_INSERT)
Return

d::
    Send {Delete}
    SetVimMode(MODE_NORMAL)
Return

y::
    Send ^c{End}
    SetVimMode(MODE_NORMAL)
Return

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ VISUAL LINE mode                                                           ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
#If gVimMode == MODE_VISUAL_LINE

; Mode changes
i::SetVimMode(MODE_INSERT)
v::SetVimMode(MODE_VISUAL)
Esc::SetVimMode(MODE_NORMAL)

; Movement
j::
    if (gVisualLineModeDirection == VISUAL_LINE_UNSET) {
        Send {Home}{Home}+{End}
        Send +{Down}+{End}
        gVisualLineModeDirection := VISUAL_LINE_DOWN
    } else if(gVisualLineModeDirection == VISUAL_LINE_DOWN) {
        Send +{Down}+{End}
    } else if(gVisualLineModeDirection == VISUAL_LINE_UP) {
        Send +{Down}+{Home}+{Home}
    }
Return

k::
    if (gVisualLineModeDirection == VISUAL_LINE_UNSET) {
        Send {End}+{Home}+{Home}
        Send +{Up}+{Home}+{Home}
        gVisualLineModeDirection := VISUAL_LINE_UP
    } else if(gVisualLineModeDirection == VISUAL_LINE_DOWN) {
        Send +{Up}+{End}
    } else if(gVisualLineModeDirection == VISUAL_LINE_UP) {
        Send +{Up}+{Home}+{Home}
    }
Return

; Other
c::
    Send {Delete}
    SetVimMode(MODE_INSERT)
Return

y::
    Send ^c{End}
    SetVimMode(MODE_NORMAL)
Return

d::
    Send {Delete}{BackSpace}
    SetVimMode(MODE_NORMAL)
Return

#If

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Other                                                                      ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
;#F12::Reload ; Useful during development, should be commented out otherwise
