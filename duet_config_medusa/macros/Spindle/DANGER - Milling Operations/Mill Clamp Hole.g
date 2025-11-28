;TYPE:START_gcode
M290 R0 S0 ; reset babystepping
M221 S100 D0 ; reset extrusion multiplier
 
;TYPE:Custom
M98 P"HomeIfNot.g"
 
T1 ; Select CNC Tool
 
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion
G21 ; set units to millimetres
 
M42 P21 S1 ; Turn on swarf blower
M3 P0 S6000
M118 P0 S"Spindle Speed: 6000 rpm" L2
G4 S5
 
M208 S0 Y690 ; break Y-max limit for milling

G91 ; Set to relative positioning

; Pass 1
G1 Z-3 F113     ; Step down 3mm
G1 Y60 F1600    ; Mill forward in Y

; Pass 2
G1 Z-3 F113
G1 Y-60 F1600

; Pass 3
G1 Z-3 F113
G1 Y60 F1600

; Pass 4
G1 Z-3 F113
G1 Y-60 F1600

; Pass 5
G1 Z-3 F113
G1 Y60 F1600

; Pass 6 (Final)
G1 Z-3 F113
G1 Y-60 F1600

G90 ; Return to absolute positioning

;TYPE:END_gcode
G91 ; relative coordinates
G53 G1 Z100 F720 ; Move print head up
G90 ; absolute coordinates
 
 
M5 ; turn off spindle
M42 P21 S0 ; Turn off swarf blower
;G4 P10000 ; wait 10 seconds for spindle to stop spinning
 
M208 S0 Y{global.ymax} ; restore Y-max limit
 
;G53 G1 X0 Y690 F7200 ; park XY axis to BACK MIDDLE
M561 ; reset mesh bed compensation
M572 S0 ; reset PA
M290 R0 S0 ; reset babystepping

