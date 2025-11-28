;Material Sensor DISABLE.g

M42 P3 S0 ; Disconnect Pellet Feed Solenoid Valve
set global.materialsensor = false
M118 P0 S"Pellet Extruder Material Sensor: DISABLED" L2