; start.g

; Logging
M98 P"0:/macros/Logging/Start Print Log.g"
set global.logMessage = {"Print started - file: " ^ job.file.fileName}
M98 P"0:/macros/Logging/Log Info.g"

M98 P"disablefildetection.g"