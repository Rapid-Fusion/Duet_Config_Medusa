;if global.home == false
;    G28 ; home

; check tool docking limit switches
G4 P20 ; debounce
if !(sensors.gpIn[6].value == 1 && sensors.gpIn[7].value == 1) ; IF both switches DON'T detect tool
    M118 P0 S"Pellet Tool Pickup Fault! Ensure pellet tool is in dock & check whether docking limit switches are engaged." L1 ; WARNING
    M99 ; exit macro

G90 ; absolute coordinates
G1 F{global.tool_change_speed} ; Set tool change speed
M201 Y{global.accel_xy} ; Set Y accel (mm/s^2)

G53 G1 X{global.pellet_x} Y{global.tool_limit_y} Z{global.pellet_z_pickup} ; Locate Tool Pickup Space
; check IR sensor for position
M208 S1 Y{global.pellet_y} ; Set Y-axis limits for tool docking/pickup
M201 Y{global.tool_accel_y} ; Set tool change Y accel (mm/s^2)
G53 G1 Y{global.pellet_y} ; Insert Tool
; check IR sensor for position

M98 P"solenoid_lock.g" ; lock solenoid

M208 S1 Y{global.tool_limit_y} ; Reset Y-axis limits
