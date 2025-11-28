; spindleCutterChange.g

G90 ; absolute positioning

if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

G53 G1 X0 Y-385 Z1000 F7200