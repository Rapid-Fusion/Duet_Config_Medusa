; Circle.g

G90

if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

T-1 P0 ; set to no tool for machine coordinates

M400
G1 Z0 F7200 ; move to 0
M400
G4 P200 ; debounce

if move.axes[2].machinePosition > 800
    M118 P0 S"Z-axis must be below 800!" L3
    M99 ; exit macro

G1 F{global.tool_change_speed} ; set feedrate to 1200 mm/s

var zpos = move.axes[2].machinePosition
M400

M203 X144000 Y144000 ; increase speed limit
M201 X24000 Y24000 ; increase maxaccelerations
M204 T10000 ; increase travel accelerations

G1 X-497.5 Y152.5

G2 X497.5 Y152.5 R497.5 Z{var.zpos+0.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+1}
M204 T24000 ; increase travel accelerations

G2 X497.5 Y152.5 R497.5 Z{var.zpos+1.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+2}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+2.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+3}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+3.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+4}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+4.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+5}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+5.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+6}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+6.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+7}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+7.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+8}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+8.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+9}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+9.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+10}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+10.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+11}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+11.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+12}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+12.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+13}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+13.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+14}

G2 X497.5 Y152.5 R497.5 Z{var.zpos+14.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+15}

M203 X72000 Y72000 ; reset default speed limit
M201 X10000 Y10000 ; reset max accelerations

G2 X497.5 Y152.5 R497.5 Z{var.zpos+15.5}
G2 X-497.5 Y152.5 R497.5 Z{var.zpos+16}

M204 T10000 ; reset travel accelerations

T{state.previousTool} P0 ; reselect previous tool
