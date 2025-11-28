; solenoid_unlock.g

M42 P1 S0 ; LEFT valve off
M42 P2 S1 ; RIGHT valve on
G4 P500 ; solenoid debounce
;M42 P2 S0 ; RIGHT valve off

if (sensors.gpIn[0].value == 1 && sensors.gpIn[1].value == 0) ; IF NOT UNLOCKED
    set global.toolChangerPistonState = "Fault"
    M118 P0 S"Fault when Unlocking Tool Changer. Check piston position and compressor air pressure." L1
    M118 P0 S{"Tool Changer Piston Sensor (TOP): "^(sensors.gpIn[0].value)^" | Tool Changer Piston Sensor (BOTTOM): "^(sensors.gpIn[1].value)^" | 0 = Inactive, 1 = Active"} L1 ; WARNING
else
    set global.toolChangerPistonState = "Unlocked"
    M118 P0 S"Tool Changer Unlocked." L2