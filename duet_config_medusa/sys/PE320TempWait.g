; PE320TempWait.g

set global.timer = state.time             ; reassigns global variable timer to current time

; prevents further gcode until Pellet Extruder has heated up for 20 minutes
;set global.pelletExtruderReady = false

; S3: "OK" and "Cancel" are displayed (blocking, send M292 to resume the execution or M292 P1 to cancel the operation in progress)
M291 S3 P"Preheating Pellet Extruder for 20 minutes..." T1200 

M118 P0 S{"Preheating Duration: "^(state.time-global.timer)^" seconds. Pellet Extruder Ready for Printing!"} L3
;set global.pelletExtruderReady = true

;M291 R"WARNING" P"Preheating Pellet Extruder for 20 minutes..." K{"Yes","Cancel"} S4
;if (input == 1)
;    echo "No chosen"

;while state.time - global.timer < 1200 ; 20 min
;	G4 P500 ; debounce
;	set global.pelletExtruderReady = true

    ; cancel wait
;	if global.cancelPreheat == true
;		set global.cancelPreheat = false
;		M118 P0 S{"WARNING: Preheating Period Cancelled."} L3
;		break


;M291 S5 R"Title" P"Message" L0 H1200 F1200
;echo {input^" entered by user"}