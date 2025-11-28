; insertfilamentLEFT.g
; Inserts 6500mm from Bondtech extruder to Dyze extruder head

M98 P"disablefildetection.g"

;if global.filLEFTstatus == true
;    M118 P0 S"Filament LEFT already present" L2
;    M98 P"enablefildetection.g"
;    M99

;M291 R"WARNING" P"Make sure filament is cut at a 45deg angle before insertion!" K{"OK","Cancel"} S4
;if (input == 0)                        ; OK selected
G90
M83
                                   ; T2 ; select Filament LEFT tool
T2 P0                              ; select Filament LEFT tool without enabling tool change macros

while true
    M302 P1                        ; allow cold extrude
    M591 D2 S0                     ; disable filament run-out detection
    G1 E0:100 F1000                ; grab filament (Bondtech only)
    G92 E0
    M302 P0                        ; disable cold extrude
    M591 D2 S2                     ; enable filament run-out detection
    if sensors.gpIn[17].value == 0 ; no filament detected
        M291 R"WARNING" P"No filament detected at LEFT extruder or faulty sensor. Please Insert Filament again!" K{"OK","Cancel"} S4
        if (input == 1)            ; Cancel selected
            M118 P0 S"LEFT Filament Insertion Cancelled." L2
            M98 P"enablefildetection.g"
            M99                    
    else
        break

;M568 P2 R280 S280 A2               ; set to PACF fil change temp
M568 P2 R{global.loadtoptemp}:{global.loadbottomtemp} S{global.loadtoptemp}:{global.loadbottomtemp} A2               ; set to PETG fil change temp
M118 P0 S"Heating up to active temperatures..." L2
M116 P2 S15                        ; wait for heater temperatures to be reached ±15 deg C
M118 P0 S"Heaters temperatures reached!" L2

M203 E14000:14000:14000:14000      ; increase max extruder speeds
M201 E1000:1000:1000:1000          ; reduce extruder accel
G1 E0:8000 F{global.loadspeed}                 ; Bondtech FAST filament insertion
M203 E3000:3000:3000:3000          ; reset max extruder speeds
M201 E10000:10000:10000:10000      ; revert extruder accel

G1 E500 F1000                      ; extrude filament

M400
;set global.filLEFTstatus = true
M118 P0 S"Filament LEFT insertion complete!" L2

M98 P"enablefildetection.g"