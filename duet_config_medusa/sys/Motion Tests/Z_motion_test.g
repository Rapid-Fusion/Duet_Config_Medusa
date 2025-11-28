; Z_motion_test.g

G90 ; absolute positioning

if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

T-1 P0 ; set to no tool for machine coordinates

G1 Z1100 F720 ; move down slowly initially

G1 F{global.tool_change_speed} ; set machine speed

; Z Motion Test
G1 Z595 ; Z at 120 mm/s
G1 Z605 ; Z at 120 mm/s

G1 Z580 ; Z at 120 mm/s
G1 Z620 ; Z at 120 mm/s

G1 Z650 ; Z at 120 mm/s
G1 Z700 ; Z at 120 mm/s

G1 Z500 ; Z at 120 mm/s
G1 Z800 ; Z at 120 mm/s

G1 Z400 ; Z at 120 mm/s
G1 Z600 ; Z at 120 mm/s