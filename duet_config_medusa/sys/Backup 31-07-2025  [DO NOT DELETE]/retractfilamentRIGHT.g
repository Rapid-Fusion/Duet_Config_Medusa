; retractfilamentRIGHT.g
; Retracts 6500mm from Bondtech extruder to Dyze extruder head

M118 P0 S"Filament RIGHT RETRACTION NOT READY. Macro Cancelled." L2
M99

M98 P"disablefildetection.g"

M42 P13 S0 ; filament retract RIGHT Button - GREEN

if move.axes[0].homed == false || move.axes[1].homed == false || move.axes[2].homed == false
    G28

T3

;if global.filRIGHTstatus == false
;    M118 P0 S"No filament RIGHT present!" L2
;    M98 P"enablefildetection.g"
;    M99

;M291 R"WARNING" P"Make sure operator is stationed at filament chamber to wind-up filament spool during retraction!" K{"OK","Cancel"} S4
;if (input == 0)                   ; OK selected
G90
M83
                              ; T3 ; select Filament RIGHT tool
T3 P0                         ; select Filament RIGHT tool without enabling tool change macros

;M568 P3 R280 S280 A2               ; set to PACF fil change temp
M568 P3 R{global.loadtoptemp}:{global.loadbottomtemp} S{global.loadtoptemp}:{global.loadbottomtemp} A2          ; set to PETG fil change temp
M118 P0 S"Heating up to active temperatures..." L2
M116 P3 S15                   ; wait for tool 1 heater temperatures to be reached ±15 deg C
M118 P0 S"Heaters temperatures reached!" L2

; Move to Filament Purge Bin
G90 ; absolute coordinates
if move.axes[2].machinePosition < 200
    G53 G1 Z200 F1800 ; move up in z to avoid bed clamps

M208 S1 Y{global.filpurgebin_y} ; break Y-limits
G53 G1 X{global.filpurgebin_x} F7200 ; Move in X (machine coordinates)
G53 G1 Y{global.filpurgebin_y} F7200 ; Move in Y (machine coordinates)

M106 S1 ; part cooling on
G1 E300 F500                  ; extrude filament to purge heatcore
G1 E-5 F1000 ; retract
M400
G4 S2 ; delay
M107 ; part cooling off

; Move away from Filament Purge Bin
G53 G1 Y{global.tool_limit_y} F7200 ; Move Y out of tool changing zone
M208 S1 Y{global.tool_limit_y} ; Reset Y limits

M400
G4 S5                         ; 5 second delay for filament to settle
G1 E-300 F500                 ; retract filament

M203 E14000:14000:14000:14000 ; increase max extruder speeds
M201 E1000:1000:1000:1000     ; reduce extruder accel
G1 E0:{-global.loadlength} F{global.loadspeed}           ; fast filament retraction
M591 D4 S0                    ; disable filament run-out detection
G1 E0:-500 F5000              ; slow filament retraction
M591 D4 S2                    ; enable filament run-out detection
M203 E3000:3000:3000:3000     ; reset max extruder speeds
M201 E10000:10000:10000:10000 ; revert extruder accel

M400
G4 P20

;set global.filRIGHTstatus = false
M118 P0 S"Filament RIGHT retraction complete!" L2

M98 P"enablefildetection.g"