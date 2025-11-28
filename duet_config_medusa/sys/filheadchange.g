; filheadchange.g
; Post processor in slicer: replace any T0/T1 commands with M98 P"filheadchange.g"

M400
G90
if !exists(param.A)
    if global.tool == "filament LEFT"    ; if LEFT extruder was selected
        ;G1 E-10 F3000                    ; retract quickly
        T1 P0                            ; select RIGHT extruder without running tool changer macros
        set global.tool = "filament RIGHT"
        G1 A0 B{10+global.filheadoffset} ; Retract LEFT & Extend RIGHT
        ;G1 E10 F3000                     ; unretract quickly
        M118 P0 S"Tool Change Successful! RIGHT extruder selected!" L3
    elif global.tool == "filament RIGHT" ; if RIGHT extruder was selected
        ;G1 E-10 F3000                    ; retract quickly
        T0 P0                            ; select RIGHT extruder without running tool changer macros
        set global.tool = "filament LEFT"
        G1 A10 B0                        ; Retract RIGHT & Extend LEFT
        ;G1 E10 F3000                     ; unretract quickly
        M118 P0 S"Tool Change Successful! LEFT extruder selected!" L3
    else
        M118 P0 S"Error in macro filheadchange.g!" L3
else
    if param.A == 0
        set global.tool = "filament LEFT"
        G1 E10 F3000                     ; unretract quickly
        M118 P0 S"Tool Change Successful! LEFT extruder selected!" L3
    elif param.A == 1
        set global.tool = "filament RIGHT"
        G1 E10 F3000                     ; unretract quickly
        M118 P0 S"Tool Change Successful! RIGHT extruder selected!" L3
    else
        M118 P0 S"Invalid tool change param. Enter 0 or 1" L3