if global.bedready == false
    M118 P0 S"Clear Bed Homing Error before printing!" L1
    if exists(job.build)
        M0 ; unconditional stop
    M99

if global.toolchangeready == false
    M118 P0 S"Clear tool change error before printing!" L1
    if exists(job.build)
        M0 ; unconditional stop with heaters off
    M99

if move.axes[0].homed == false || move.axes[1].homed == false || move.axes[2].homed == false
    G28 ; home

G29 S1 ; load existing mesh
set global.first_mesh = true

; Mesh Level ONLY on first heatup
;if global.first_mesh != true
;    T-1 ; deselect tool
;    G29 ; Mesh Level
;else
;    G29 S1 ; load existing mesh