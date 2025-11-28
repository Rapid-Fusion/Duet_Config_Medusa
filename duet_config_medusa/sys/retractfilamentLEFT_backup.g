; retractfilamentLEFT.g
; Retracts 6500mm from Bondtech extruder to Dyze extruder head

M98 P"disablefildetection.g"

;if global.filLEFTstatus == false
;    M118 P0 S"No filament LEFT present!" L2
;    M98 P"enablefildetection.g"
;    M99

;M291 R"WARNING" P"Make sure operator is stationed at filament chamber to wind-up filament spool during retraction!" K{"OK","Cancel"} S4
;if (input == 0)                   ; OK selected
G90
M83
                              ; T2 ; select Filament LEFT tool
T2 P0                         ; select Filament LEFT tool without enabling tool change macros

;M568 P2 R280 S280 A2          ; set to PACF fil change temp
M568 P2 R{global.loadtoptemp}:{global.loadbottomtemp} S{global.loadtoptemp}:{global.loadbottomtemp} A2          ; set to PETG fil change temp
M118 P0 S"Heating up to active temperatures..." L2
M116 P2 S15                   ; wait for heater temperatures to be reached ±15 deg C
M118 P0 S"Heaters temperatures reached!" L2
G1 E-200 F1000                ; retract filament slowly

M203 E14000:14000:14000:14000 ; increase max extruder speeds
M201 E1000:1000:1000:1000     ; reduce extruder accel
G1 E{0}:{-global.loadlength} F{global.loadspeed}           ; Bondtech FAST filament retraction
M591 D2 S0                    ; disable filament run-out detection
G1 E0:-500 F5000              ; slow filament retraction
M591 D2 S2                    ; enable filament run-out detection

M203 E3000:3000:3000:3000     ; reset max extruder speeds
M201 E10000:10000:10000:10000 ; revert extruder accel

;set global.filLEFTstatus = false
M118 P0 S"Filament LEFT retraction complete!" L2

M98 P"enablefildetection.g"