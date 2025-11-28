; XYZ_motion_test.g

G90 ; absolute positioning

;if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
;    G28 ; home

;T-1 P0 ; set to no tool for machine coordinates

;G1 Z1100 F720 ; move down slowly initially

G1 F{global.tool_change_speed} ; set machine speed

; Loop 1
G1 X-650 Y-688 Z595
G1 X650 Y-688 Z605
G1 X650 Y690 Z580
G1 X-650 Y690 Z620
G1 X-650 Y-688 Z650

; Loop 2
G1 X650 Y690 Z700
G1 X-650 Y690 Z500
G1 X650 Y-688 Z800
G1 X-650 Y-688 Z400

; Loop 3
G1 X650 Y-688 Z600
G1 X-650 Y690 Z595
G1 X650 Y690 Z605
G1 X-650 Y-688 Z580

; End of program
