G90 ; absolute coordinates

G1 F{global.tool_change_speed} ; Set tool change speed
M201 Y{global.tool_accel_y} ; Set tool change Y accel (mm/s^2)

M208 S1 Y{global.pellet_y} ; Set tool change Y limits
G53 G1 Y{global.tool_limit_y} ; Slide out Tool to ready position

M208 S1 Y{global.tool_limit_y} ; Reset axis limits
M201 Y{global.accel_xy} ; Reset Y accel (mm/s^2)

M118 P0 S"Pellet Tool Ejected" L2
