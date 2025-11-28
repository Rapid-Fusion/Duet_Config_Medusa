; mesh.g

; G29 runs "mesh.g"

if global.bedready == false
    M118 P0 S"Clear Bed Homing Error before bed mesh leveling!" L1
    if exists(job.build)                                    ; if job build exists
        M0 H0                                               ; unconditional stop with heaters off
    M99

if global.toolchangeready == false
    M118 P0 S"Clear tool change error before bed mesh leveling!" L1
    if exists(job.build)                                    ; if job build exists
        M0 H0                                               ; unconditional stop with heaters off
    M99

if sensors.probes[0].value[0] >= sensors.probes[0].threshold
    M118 P0 S"Probe already triggered at start of probing move. Raise Z up by 5 mm & restart mesh levelling." L1
    if exists(job.build)                                    ; if job build exists
        M0 H0                                               ; unconditional stop with heaters off
    M99

M98 P"HomeIfNot.g"
T-1                                                         ; deselect tools (tool change if tool present)
M400
G29 S2                                                      ; clear existing mesh & disable mesh level

G1 X0 Y0 F7200                                              ; Move to centre
G1 Z100 F7200
G1 Z{sensors.probes[0].diveHeights[0]} F1800                ; Move to probe dive height 10mm above bed

var timer = state.time                                      ; initialise timer

G30 S-1                                                     ; probes and reports the Z value when the probe triggers
G4 P20                                                      ; debounce

; [Scan height = 5 mm, Scan range = 3.5-7.5mm]
var scan_range = 1.5                                        ; height to scan above & below trigger height (S) 
G1 Z{sensors.probes[0].triggerHeight + var.scan_range} F720 ; move to max scan range height (7.5mm)
 
M400
set global.probeoverride = true
G4 P500                                                     ; debounce
M558.1 K0 S{var.scan_range}                                 ; Calibrate height vs reading of scanning Z probe -- height to scan above & below trigger height (S)
set global.probeoverride = false
M400

G1 Z{sensors.probes[0].triggerHeight} F720
M208 Y-690:690                                              ; set axis maximum limits for mesh leveling
M201 X5000 Y5000                                            ; set XY accel for mesh levelling
G4 P20                                                      ; debounce

G29 S0 K0                                                   ; mesh bed level
G1 Z{sensors.probes[0].diveHeights[0]} F720                 ; move z out of mesh compensation zone to dive height (10mm)

M201 X{global.accel_xy} Y{global.accel_xy}                  ; reset X accel
G1 X0 Y0 F7200                                              ; Move to centre

M208 S1 Y{global.tool_limit_y}                              ; reset default axis limits
M118 P0 S{"Mesh Levelling Complete! Duration: "^(state.time-var.timer)^" seconds"} L1