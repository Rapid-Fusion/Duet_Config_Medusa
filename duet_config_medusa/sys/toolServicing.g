; toolServicing.g

if global.toolchangeready == false
    M118 P0 S"Clear tool change error before moving to Tool Service Position!" L1
    M99

G90 ; absolute positioning

if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

;if state.currentTool == 1 ; spindle
;    G53 G1 X0 Y-450 F7200
;    G53 G1 Z1155 F7200
;else ; no tool & other tools

G53 G1 Z1200 F7200 ; move up
M400

if state.currentTool != 1 ; if not CNC picked up, then allow moving down
    G53 G1 Z500 F3600 ; move down to servicing position

M400
G53 G1 X0 Y-450 F7200 ; move to XY