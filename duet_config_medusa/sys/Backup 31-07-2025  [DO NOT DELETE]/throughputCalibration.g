; throughputCalibration.g

G90 ; absolute coordinates

if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

T0 ; select pellet extruder

M98 P"toolServicing.g" ; move to Service position

