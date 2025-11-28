; retractfilamentLEFT.g
; Retracts 6500mm from Bondtech extruder to Dyze extruder head

M98 P"disablefildetection.g"

M42 P11 S0 ; filament retract LEFT Button - GREEN

if move.axes[0].homed == false || move.axes[1].homed == false || move.axes[2].homed == false
    G28
    
T2

;if global.filLEFTstatus == false
;    M118 P0 S"No filament LEFT present!" L2
;    M98 P"enablefildetection.g"
;    M99

;M291 R"WARNING" P"Make sure operator is stationed at filament chamber to wind-up filament spool during retraction!" K{"OK","Cancel"} S4
;if (input == 0)                   ; OK selected
G90
M83
;                              ; T2 ; select Filament LEFT tool
;T2 P0                         ; select Filament LEFT tool without enabling tool change macros

;M568 P2 R280 S280 A2          ; set to PACF fil change temp
;M568 P2 R180:220 S180:220 A2          ; set to PETG fil change temp
M568 P2 R230 S230 A2 ; PLA temp
M118 P0 S"Heating up to active temperatures..." L2
M116 P2 S20                   ; wait for heater temperatures to be reached ±20 deg C
M118 P0 S"Heaters temperatures reached!" L2

; Move to Filament Purge Bin
G90 ; absolute coordinates
if move.axes[2].machinePosition < 200
    G53 G1 Z200 F1800 ; move up in z to avoid bed clamps
    
M208 S1 Y{global.filpurgebin_y} ; break Y-limits
G53 G1 X{global.filpurgebin_x} F7200 ; Move in X (machine coordinates)
G53 G1 Y{global.filpurgebin_y} F7200 ; Move in Y (machine coordinates)

;M106 S1 ; part cooling on
G1 E20 F300                  ; extrude filament to purge heatcore
G1 E-5 F1000 ; retract
M400
G4 S2 ; delay
;M107 ; part cooling off

; Move away from Filament Purge Bin
G53 G1 Y{global.tool_limit_y} F7200 ; Move Y out of tool changing zone
M208 S1 Y{global.tool_limit_y} ; Reset Y limits

M400
G4 S5                         ; 5 second delay for filament to settle
G1 E-100 F300                 ; retract filament

M203 E1838.621:14000:14000:14000:14000 ; increase max extruder speeds
M201 E500:1000:1000:1000:1000     ; reduce extruder accel
G1 E0:-8000:-8000 F{global.loadspeed}           ; Bondtech FAST filament retraction
;M591 D2 S0                    ; disable filament run-out detection
G1 E0:-400:-400 F5000              ; slow filament retraction
;M591 D2 S2                    ; enable filament run-out detection

M203 E1838.621:3000:3000:3000:3000     ; reset max extruder speeds
M201 E500:10000:10000:10000:10000 ; revert extruder accel

M400
G4 P20

;set global.filLEFTstatus = false
M118 P0 S"Filament LEFT retraction complete!" L2

M98 P"enablefildetection.g"