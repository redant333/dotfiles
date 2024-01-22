#Requires AutoHotkey v2.0

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Configuration                                                              ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
global HINT_BG := "232E21"
global HINT_FG := "FFFFFF"
global HINT_BG := "0F5257"
; global HINT_FG := "FFFFFF"
global HINT_FONT_SIZE := "12"
global HINT_FONT_FAMILY := "Consolas"
global HINT_WIDTH := "30"
global HINT_HEIGHT := "21"

global HINT_SYMBOLS := ["/", "M", "N", "B", "V", "C", "X", "Z", ";", "L", "K", "J", "H", "G", "F", "D", "S", "A", "P", "O", "I", "U", "Y", "T", "R", "E", "W", "Q"]

global TRANSPARENT_COLOR := "FEFEFE"

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Global variables                                                           ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
global gOverlayActive := False
global gHintToLocationMap := Map()
global gOverlay := Gui("+AlwaysOnTop -Caption +ToolWindow")
global gHotkeyBuffer := ""

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Functions                                                                  ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
PrepareOverlay() {
    ; Initialize the window
    gOverlay.SetFont(Format("c{1} s{2} bold", HINT_FG, HINT_FONT_SIZE), HINT_FONT_FAMILY)
    gOverlay.BackColor := TRANSPARENT_COLOR
    WinSetTransColor(TRANSPARENT_COLOR, gOverlay)

    ; Initialize the labels
    firstIndex := 1
    xStep := A_ScreenWidth / HINT_SYMBOLS.Length
    yStep := A_ScreenHeight / HINT_SYMBOLS.Length

    while firstIndex <= HINT_SYMBOLS.Length {
        secondIndex := 1
        while secondIndex <= HINT_SYMBOLS.Length {
            x := firstIndex * xStep - xStep / 2
            y := secondIndex * yStep

            ; Offset the y location of some hints to get a nicer pattern
            if Mod(firstIndex, 2) == 1 {
                y -= yStep / 2
            }

            hint := HINT_SYMBOLS[firstIndex] HINT_SYMBOLS[secondIndex]
            gHintToLocationMap[hint] := {x: x, y: y}

            gOverlay.AddText(Format("Background{1} x{4} y{5} w{2} h{3} +Center", HINT_BG, HINT_WIDTH, HINT_HEIGHT, x, y), hint)

            secondIndex++
        }
        firstIndex++
    }
}

InitializeHotkeys() {
    for key in HINT_SYMBOLS {
        Hotkey key, OnHintKeyPressed
        Hotkey key, "Off"
    }
}

OnHintKeyPressed(key) {
    global gHotkeyBuffer
    gHotkeyBuffer .= key

    if StrLen(gHotkeyBuffer) = 2 {
        position := gHintToLocationMap[gHotkeyBuffer]
        ToggleOverlay()
        MouseClick "left", position.x, position.y
    }
}

ToggleOverlay() {
    global gOverlayActive 
    gOverlayActive := not gOverlayActive

    if gOverlayActive {
        gOverlay.Show("NoActivate w" A_ScreenWidth "h" A_ScreenHeight "x0 y0")

        for key in HINT_SYMBOLS {
           Hotkey key, "On"
        }

        global gHotkeyBuffer := ""
    } else {
        gOverlay.Hide()

        for key in HINT_SYMBOLS {
           Hotkey key, "Off"
        }
    }
}

;┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
;┃ Initialization and static hotkeys                                          ┃
;┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
PrepareOverlay()
InitializeHotkeys()
CoordMode "Mouse" , "Screen"

#j::ToggleOverlay()

; #F12::Reload ; Useful during development, should be commented out otherwise
