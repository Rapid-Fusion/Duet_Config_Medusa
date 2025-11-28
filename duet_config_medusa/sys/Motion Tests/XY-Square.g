; XY-Square.g

G90 ; absolute coordinates

if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

;T-1 P0 ; set to no tool for machine coordinates

M201 X{global.accel_xy} Y{global.accel_xy} Z500

; Run in machine coordinates
G1 F{global.tool_change_speed}
G53 G1 X-650 Y-688 ; XY at 1200 mm/s
G53 G1 X650 Y-688 ; XY at 1200 mm/s
G53 G1 X650 Y690 ; XY at 1200 mm/s
G53 G1 X-650 Y690 ; XY at 1200 mm/s
G53 G1 X-650 Y-688 ; XY at 1200 mm/s

G53 G1 X650 Y690 ; XY at 1200 mm/s
G53 G1 X-650 Y690 ; XY at 1200 mm/s
G53 G1 X650 Y-688 ; XY at 1200 mm/s
G53 G1 X-650 Y-688 ; XY at 1200 mm/s

G53 G1 X650 Y-688 ; XY at 1200 mm/s
G53 G1 X-650 Y690 ; XY at 1200 mm/s
G53 G1 X650 Y690 ; XY at 1200 mm/s
G53 G1 X-650 Y-688 ; XY at 1200 mm/s
