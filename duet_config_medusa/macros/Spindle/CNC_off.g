; CNC_off.g

M5 ; turn off spindle
M118 P0 S"Spindle OFF" L2

M98 P"0:/macros/Spindle/Swarf Blaster OFF.g"
M98 P"0:/macros/Spindle/Swarf Extraction OFF.g"