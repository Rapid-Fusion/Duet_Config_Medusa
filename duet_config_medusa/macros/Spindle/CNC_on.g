; CNC_on.g

;T1 ; Tool Change -- Spindle
M3 P0 S10000 ; CNC mode, turn on spindle at speed of 10000 RPM, clockwise (max 24000rpm)
M118 P0 S"Spindle Speed: 10000rpm" L2

M98 P"0:/macros/Spindle/Swarf Blaster ON.g"
M98 P"0:/macros/Spindle/Swarf Extraction ON.g"