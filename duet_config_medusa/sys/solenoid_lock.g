; solenoid_lock.g

M42 P2 S0 ; RIGHT valve off
M42 P1 S1 ; LEFT valve on
G4 P500 ; solenoid debounce
;M42 P1 S0 ; LEFT valve off

if (sensors.gpIn[0].value == 0 && sensors.gpIn[1].value == 1) ; IF NOT LOCKED
    set global.toolChangerPistonState = "Fault"
    M118 P0 S"Fault when Locking Tool Changer. Check piston position and compressor air pressure." L1
    M118 P0 S{"Tool Changer Piston Sensor (TOP): "^(sensors.gpIn[0].value)^" | Tool Changer Piston Sensor (BOTTOM): "^(sensors.gpIn[1].value)^" | 0 = Inactive, 1 = Active"} L1 ; WARNING
else
    set global.toolChangerPistonState = "Locked"
    M118 P0 S"Tool Changer Locked." L2
