G90

M208 S1 Y{global.filament_y} ; Set tool change Y limits
G53 G1 Z{global.filament_z_dock} F720 ; Raise Tool SLOWLY

; check tool docking limit switches
G4 P20 ; debounce
if !(sensors.gpIn[10].value == 0 && sensors.gpIn[11].value == 0) ; IF both switches detect a tool
    M118 P0 S"Filament Tool Pickup Fault! Check filament docking limit switches. Tool Changer is LOCKED." L1 ; WARNING
    M99 ; exit macro

G1 F{global.tool_change_speed} ; Set tool change speed
M201 Y{global.tool_accel_y} ; Set tool change Y accel (mm/s^2)
G53 G1 Y{global.tool_limit_y} ; Slide out Tool to Ready position

M208 S1 Y{global.tool_limit_y} ; Reset Y limits
M201 Y{global.accel_xy} ; Reset Y accel (mm/s^2)

M118 P0 S"Filament Tool Picked Up!" L2
