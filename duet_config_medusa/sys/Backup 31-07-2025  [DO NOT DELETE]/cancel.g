; cancel.g - executed when print is cancelled
; Logging
set global.logMessage = "Print cancelled by user"
M98 P"0:/macros/Logging/Log Warn.g"
M98 P"0:/macros/Logging/Stop Logging.g"
M98 P"0:/macros/Logging/Start Logging.g"

set global.printing = false