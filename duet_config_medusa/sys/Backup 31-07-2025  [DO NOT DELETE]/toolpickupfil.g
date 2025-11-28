;if global.home == false
;    G28 ; home

; check tool docking limit switches
G4 P20 ; debounce
if !(sensors.gpIn[10].value == 1 && sensors.gpIn[11].value == 1) ; IF both switches DON'T detect tool
    M118 P0 S"Filament Tool Pickup Fault! Ensure filament tool is in dock & check whether docking limit switches are engaged." L1 ; WARNING
    M99 ; exit macro

G90 ; absolute coordinates
G1 F{global.tool_change_speed} ; Set tool change speed
M201 Y{global.accel_xy} ; Set Y accel (mm/s^2)

G53 G1 X{global.filament_x} Y{global.tool_limit_y} Z{global.filament_z_pickup} ; Locate Tool Pickup Space
; check IR sensor for position
M208 S1 Y{global.filament_y} ; Set Y-axis limits for tool docking/pickup
M201 Y{global.tool_accel_y} ; Set tool change Y accel (mm/s^2)
G53 G1 Y{global.filament_y} ; Insert Tool
; check IR sensor for position

M98 P"solenoid_lock.g" ; lock solenoid

M208 S1 Y{global.tool_limit_y} ; Reset Y-axis limits
