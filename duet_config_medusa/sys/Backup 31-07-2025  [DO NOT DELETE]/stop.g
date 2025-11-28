; stop.g

; Logging
set global.logMessage = {"Print complete - duration: " ^ floor(job.duration/3600) ^ " hrs " ^ floor(mod(job.duration,3600)/60) ^ " min (" ^ job.duration ^ " sec)"}
M98 P"0:/macros/Logging/Log Info.g"
M98 P"0:/macros/Logging/Stop Logging.g"
M98 P"0:/macros/Logging/Start Logging.g"

M98 P"enablefildetection.g"

set global.printing = false