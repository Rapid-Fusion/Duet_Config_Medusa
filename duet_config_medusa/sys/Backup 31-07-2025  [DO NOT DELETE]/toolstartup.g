; toolstartup.g

; Pellet Tool Selected
if (sensors.gpIn[6].value == 0 && sensors.gpIn[7].value == 0 && sensors.gpIn[8].value == 1 && sensors.gpIn[9].value == 1 && sensors.gpIn[10].value == 1 && sensors.gpIn[11].value == 1)                                                                
    T0 P0                  ; select pellet tool on startup
    M568 P0 R0 S0 A0       ; set initial tool #0 active, standby temperatures to 0C, state OFF
    M302 S80 R80           ; ONLY Allow Extrusion from 80 deg and above
    M98 P"solenoid_lock.g" ; lock solenoid on startup
    M118 P0 S"Pellet Tool Selected!" L2
    M99

; CNC Spindle Tool Selected
if (sensors.gpIn[6].value == 1 && sensors.gpIn[7].value == 1 && sensors.gpIn[8].value == 0 && sensors.gpIn[9].value == 0 && sensors.gpIn[10].value == 1 && sensors.gpIn[11].value == 1)                                                                
    T1 P0                  ; select cnc tool on startup
    M98 P"solenoid_lock.g" ; lock solenoid on startup
    M118 P0 S"CNC Tool Selected!" L2
    M99

; Filament Tool Selected
if (sensors.gpIn[6].value == 1 && sensors.gpIn[7].value == 1 && sensors.gpIn[8].value == 1 && sensors.gpIn[9].value == 1 && sensors.gpIn[10].value == 0 && sensors.gpIn[11].value == 0)                                                                
    T2 P0                  ; select filament tool (LEFT) on startup
    M568 P2 R0 S0 A0       ; set initial tool #2 active, standby temperatures to 0C, state OFF
    M302 S80 R80           ; ONLY Allow Extrusion from 80 deg and above
    M98 P"solenoid_lock.g" ; lock solenoid on startup
    M118 P0 S"Filament Tool (LEFT) Selected!" L2
    G90
    G0 A{global.filLEFTExtend} B0
    M99

if (sensors.gpIn[6].value == 1 && sensors.gpIn[7].value == 1 && sensors.gpIn[8].value == 1 && sensors.gpIn[9].value == 1 && sensors.gpIn[10].value == 1 && sensors.gpIn[11].value == 1)                                                                
    T-1 P0 ; select no tool
    M118 P0 S"No Tool Selected!" L2
    M99

M118 P0 S"Fault! Check tool docking limit switches." L1
set global.toolchangeready = false
M98 P"solenoid_lock.g" ; lock solenoid on startup