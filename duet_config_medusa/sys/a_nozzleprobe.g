; a_nozzleprobe.g
; Probes filament nozzle on bed to set perfect 0 position

; MUST NOZZLE PROBE BEFORE EVERY START OF A PRINT!!!

M400
set global.nozzleprobe = false

if global.toolchangeready == false
    M118 P0 S"Clear tool change error before nozzle probing" L3
    if exists(job.build)
        M0 ; unconditional stop
    M99

if !(state.currentTool == 2 || state.currentTool == 3)
    M118 P0 S"Please select Filament Tool before nozzle probing!" L1
    if exists(job.build)
        M0 ; unconditional stop
    M99

if global.first_mesh == false
    M118 P0 S"Mesh bed level before nozzle probing!" L3
    if exists(job.build)
        M0 ; unconditional stop
    M99

if !(state.currentTool == 2 || state.currentTool == 3)
    M118 P0 S"Please select Filament Tool before nozzle probing!" L1
    if exists(job.build)
        M0 ; unconditional stop
    M99


if move.axes[0].homed = false || move.axes[1].homed = false || move.axes[2].homed = false
    G28 ; home

M106 S0 ; part cooling fan off

G91
G1 Z2 F720 ; raise up
G90

M290 R0 S0 ; reset babystepping

G90
M400
G29 S1 ; enable mesh

G1 Z100 F7200
G1 X525.9 Y-612 F7200
G0 A0 B0 ; retract extruder heads

M400
G1 Z0 F720 ; move to nozzle probe position

; Nozzle probe
;M913 A50 ; 50% of normal current
G4 P500

if state.currentTool == 2
    G0 A10
elif state.currentTool == 3
    G0 B10

;M913 A100 ; 100% of normal current
G4 P1000

M290 R0 S0.80 ; babystep up TEMP

G1 Z1 F720 ; raise up after probing

set global.nozzleprobe = true

; Purge line
G90
G1 X525.9 Y-612 F7200 ; move to purge position
G1 X200 E150 F500 ; purge line

;G1 E-1.4 ; retract 
;G1 Z3 F720 ; raise up after purging

