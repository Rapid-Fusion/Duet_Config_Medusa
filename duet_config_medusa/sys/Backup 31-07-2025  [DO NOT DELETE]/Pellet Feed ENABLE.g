;Material Sensor ENABLE.g

M42 P3 S1 ; Enable Pellet Feed Solenoid Valve
set global.materialsensor = true
M118 P0 S"Pellet Extruder Material Sensor: ENABLED" L2