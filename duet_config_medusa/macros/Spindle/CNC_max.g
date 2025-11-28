; CNC_max.g

;T1 ; Tool Change -- Spindle
M3 P0 S24000 ; CNC mode, turn on spindle at speed of 24000 RPM, clockwise (max 24000rpm)
M118 P0 S"Spindle Speed: 24000rpm" L2

M98 P"0:/macros/Spindle/Swarf Blaster ON.g"
M98 P"0:/macros/Spindle/Swarf Extraction ON.g"