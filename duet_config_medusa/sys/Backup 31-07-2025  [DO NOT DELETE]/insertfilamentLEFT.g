; insertfilamentLEFT.g
; Inserts 6500mm from Bondtech extruder to Dyze extruder head

M98 P"disablefildetection.g"

M42 P10 S0 ; filament insert LEFT Button - GREEN

if move.axes[0].homed == false || move.axes[1].homed == false || move.axes[2].homed == false
    G28

T2

;if global.filLEFTstatus == true
;    M118 P0 S"Filament LEFT already present" L2
;    M98 P"enablefildetection.g"
;    M99

;M291 R"WARNING" P"Make sure filament is cut at a 45deg angle before insertion!" K{"OK","Cancel"} S4
;if (input == 0)                        ; OK selected
G90
M83
;                                   ; T2 ; select Filament LEFT tool
;T2 P0                              ; select Filament LEFT tool without enabling tool change macros

while true
    M302 P1                        ; allow cold extrude
    ;M591 D2 S0                     ; disable filament run-out detection
    G1 E0:100:100 F500                ; grab filament (Bondtech only)
    G92 E0
    M302 P0                        ; disable cold extrude
    ;M591 D2 S2                     ; enable filament run-out detection

    ; comment out until new dyze 1.75 sentinel & orthus sensors purchased
    M400
    break
    ;if sensors.gpIn[17].value == 0 ; no filament detected
    ;    M291 R"WARNING" P"No filament detected at LEFT extruder or faulty sensor. Please Insert Filament again!" K{"OK","Cancel"} S4
    ;    if (input == 1)            ; Cancel selected
    ;        M118 P0 S"LEFT Filament Insertion Cancelled." L2
    ;        M98 P"enablefildetection.g"
    ;        M99                    
    ;else
    ;    break

;M568 P2 R280 S280 A2               ; set to PACF fil change temp
;M568 P2 R180:220 S180:220 A2               ; set to PETG fil change temp
M568 P2 R230 S230 A2 ; Impact PLA temp
M118 P0 S"Heating up to active temperatures..." L2
M116 P2 S20                        ; wait for heater temperatures to be reached ±20 deg C
M118 P0 S"Heaters temperatures reached!" L2

M203 E1838.621:14000:14000:14000:14000      ; increase max extruder speeds
M201 E500:1000:1000:1000:1000          ; reduce extruder accel
G1 E0:8400:8400 F{global.loadspeed}     ; Bondtech FAST filament insertion
M203 E1838.621:3000:3000:3000:3000          ; reset max extruder speeds
M201 E500:10000:10000:10000:10000      ; revert extruder accel

M400
G4 P20

; Move to Filament Purge Bin
G90 ; absolute coordinates
if move.axes[2].machinePosition < 200
    G53 G1 Z200 F1800 ; move up in z to avoid bed clamps

M208 S1 Y{global.filpurgebin_y} ; break Y-limits
G53 G1 X{global.filpurgebin_x} F7200 ; Move in X (machine coordinates)
G53 G1 Y{global.filpurgebin_y} F7200 ; Move in Y (machine coordinates)

;M106 S1 ; part cooling on
G1 E100 F300                      ; extrude filament
G1 E-5 F1000 ; retract
M400
G4 S2 ; delay
;M107 ; part cooling off

; Move away from Filament Purge Bin
G53 G1 Y{global.tool_limit_y} F7200 ; Move Y out of tool changing zone
M208 S1 Y{global.tool_limit_y} ; Reset Y limits

M400
G4 P20

;set global.filLEFTstatus = true
M118 P0 S"Filament LEFT insertion & purge complete!" L2

M98 P"enablefildetection.g"