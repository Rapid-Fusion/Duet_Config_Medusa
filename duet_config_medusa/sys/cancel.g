; cancel.g - executed when print is cancelled

; Stop Tool Fan
M106 S0

M42 P3 S0 ; Disconnect Pellet Feed Solenoid Valve
set global.materialsensor = false
M118 P0 S"Pellet Extruder Material Sensor: DISABLED" L2

; Logging
set global.logMessage = "Print cancelled by user"
M98 P"0:/macros/Logging/Log Warn.g"
M98 P"0:/macros/Logging/Stop Logging.g"
M98 P"0:/macros/Logging/Start Logging.g"

set global.printing = false