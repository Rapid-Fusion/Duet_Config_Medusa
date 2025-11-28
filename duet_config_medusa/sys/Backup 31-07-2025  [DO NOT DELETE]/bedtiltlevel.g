; bedtiltlevel.g

var count = 0
var mode = 3                                                                                   ;  terminate the move when the endstop switch is triggered and set the axis limit to the current position, overriding the value that was set by M208

var u_x = 392
var u_y = 460
var v_x = -328
var v_y = 460
var w_x = -560
var w_y = -550
var c_x = 635
var c_y = -550

var u_pos = global.bed_tilt_height
var v_pos = global.bed_tilt_height
var w_pos = global.bed_tilt_height
var c_pos = global.bed_tilt_height
var u_pos_diff = 0
var v_pos_diff = 0
var w_pos_diff = 0
var c_pos_diff = 0
var u_pos_adjust = 0
var v_pos_adjust = 0
var w_pos_adjust = 0
var c_pos_adjust = 0
var gantryheight = sensors.probes[0].diveHeights[0]                  ; 10mm dive height
var triggerdiff = var.gantryheight - sensors.probes[0].triggerHeight ; 10mm dive - 6mm trigger (CF) OR 10mm dive - 5mm trigger (ALU)
var bedthreshold = 0.05
var bedfinaladjust = 0


M291 R"WARNING" P"Make sure Bed is COLD & CLEAR before running this test!" K{"OK","Cancel"} S4
; WARNING - Scanning the Bed while hot results in erronous probe readings (bed becomes closer than expected, which could result in crashing during filament prints)
if (input == 1)                                                                                ; Cancel selected
    M118 P0 S"Bed Tilt Levelling cancelled" L1
    M99

var timer = state.time                                                                         ; initialise timer

if !exists(global.bedtiltlevel)
	global bedtiltlevel = false
else
	set global.bedtiltlevel = false

M118 P0 S{"Bed Tilt Levelling Starting..."} L2

G32                                                                                            ; home bed to bottom

if global.bedready == false
    M118 P0 S"Clear Bed Homing Error before bed tilt leveling!" L1
    M99

M400
G28                                                                                            ; home gantry [MUST]
M400

M118 P0 S{"Deselecting Tool..."} L2

T-1
M400

if global.toolchangeready == false
    M118 P0 S"Clear tool change error before bed tilt leveling!" L1
    M99

M118 P0 S{"Gantry Moving to Probe Dive Height (Z=10mm)"} L2

G90                                                                                            ; absolute positioning
G1 X0 Y0 F{global.tool_change_speed}                                                           ; Move to middle
G1 Z100 F7200                                                                                  ; Move to Z=100 fast
G1 Z{sensors.probes[0].diveHeights[0]} F720                                                    ; move z to dive height (10mm)

; Initialise Bed tilt levelling variables
M208 Y-580:460                                                                                 ; set axis limits for bed probing

G92 U0 V0 W0 C0 ; reset bed home

; Raise Bed to Pre-calibrated dive height level where Z=10
M400
G4 P20 ; debounce

M118 P0 S{"Raising Back Screwjacks..."} L2
G1 U{global.bed_tilt_height} V{global.bed_tilt_height} F{global.bed_lift_speed} ; lift bed off ground - back (U & V)
M400
G4 P20 ; debounce
M118 P0 S{"Back Screwjacks Raised."} L2

M118 P0 S{"Raising Front Screwjacks..."} L2
G1 W{global.bed_tilt_height} C{global.bed_tilt_height} F{global.bed_lift_speed} ; lift bed off ground - font (W & C)
M400
G4 P20 ; debounce
M118 P0 S{"Front Screwjacks Raised."} L2

M118 P0 S{"Bed Moved Up to Probe Position."} L2
M118 P0 S{"Probing Bed..."} L2
G30 S-1 ; probe bed
G4 P20 ; debounce
set var.gantryheight = move.axes[2].machinePosition
echo "Theoretical Dive Height: "^sensors.probes[0].diveHeights[0]^" mm | Actual Dive Height: "^(var.gantryheight+var.triggerdiff)^" mm"   
M400
G4 P20 ; debounce

G1 Z{sensors.probes[0].diveHeights[0]} F720                                                    ; move z back to dive height (10mm)

; Bed tilt levelling start
while var.count < 5
    ; Tilt U screwjack
    M118 P0 S{"Moving gantry to U screwjack..."} L2
    G1 X{var.u_x} Y{var.u_y} F{global.tool_change_speed}                                       ; Move to U screwjack
    M118 P0 S{"Gantry at U screwjack."} L2
    M400
    G4 P20                                                                                     ; debounce
    if sensors.probes[0].value[0] > sensors.probes[0].threshold
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L1
        set global.bedtiltlevel = false
        M99
    G91                                                                                        ; relative positioning
    set var.u_pos = move.axes[5].machinePosition
    M574 U2 S2                                                                                 ; configure Z-probe as U axis endstop 
    G4 P20                                                                                     ; debounce
    echo move.axes[5].machinePosition
    G1 H{var.mode} U10 F{global.bed_lift_speed}                                                ; Move bed up and terminate move when z-probe endstop is triggered and update the current position
    M118 P0 S{"U screwjack Height measurement complete. Calculating Height Difference..."} L2
    M400
    G4 P20
    echo move.axes[5].machinePosition                                                                                     ; debounce
    set var.u_pos_diff = move.axes[5].machinePosition - var.u_pos
    echo var.u_pos_diff
    if var.u_pos_diff <= 0
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L1
        set global.bedtiltlevel = false
        M99
    M574 U0 S2                                                                                 ; disable Z-probe as U axis endstop
    G90                                                                                        ; absolute positioning
    M118 P0 S{"Resetting to U screwjack..."} L2
    G1 U{var.u_pos} V{var.v_pos} W{var.w_pos} C{var.c_pos} F{global.bed_lift_speed}            ; Move down
    M118 P0 S{"U screwjack Height measurement complete."} L2

    ; Tilt V screwjack
    M118 P0 S{"Moving gantry to V screwjack..."} L2
    G1 X{var.v_x} Y{var.v_y} F{global.tool_change_speed}                                       ; Move to V screwjack
    M118 P0 S{"Gantry at V screwjack."} L2
    M400
    G4 P20                                                                                     ; debounce
    if sensors.probes[0].value[0] > sensors.probes[0].threshold
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L1
        set global.bedtiltlevel = false
        M99
    G91                                                                                        ; relative positioning
    set var.v_pos = move.axes[6].machinePosition
    M574 V2 S2                                                                                 ; configure Z-probe as V axis endstop 
    G4 P20                                                                                     ; debounce
    echo move.axes[6].machinePosition
    G1 H{var.mode} V10 F{global.bed_lift_speed}                                                ; Move bed up and terminate move when z-probe endstop is triggered and update the current position
    M118 P0 S{"V screwjack Height measurement complete. Calculating Height Difference..."} L2
    M400
    G4 P20                                                                                     ; debounce
    echo move.axes[6].machinePosition
    set var.v_pos_diff = move.axes[6].machinePosition - var.v_pos
    echo var.v_pos_diff
    if var.v_pos_diff <= 0
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L1
        set global.bedtiltlevel = false
        M99
    M574 V0 S2                                                                                 ; disable Z-probe as V axis endstop 
    G90                                                                                        ; absolute positioning
    M118 P0 S{"Resetting to V screwjack..."} L2
    G1 U{var.u_pos} V{var.v_pos} W{var.w_pos} C{var.c_pos} F{global.bed_lift_speed}            ; Move down
    M118 P0 S{"V screwjack Height measurement complete."} L2

    ; Tilt W screwjack
    M118 P0 S{"Moving gantry to W screwjack..."} L2
    G1 X{var.w_x} Y{var.w_y} F{global.tool_change_speed}                                       ; Move to W screwjack
    M118 P0 S{"Gantry at W screwjack."} L2
    M400
    G4 P20                                                                                     ; debounce
    if sensors.probes[0].value[0] > sensors.probes[0].threshold
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L1
        set global.bedtiltlevel = false
        M99
    G91                                                                                        ; relative positioning
    set var.w_pos = move.axes[7].machinePosition
    M574 W2 S2                                                                                 ; configure Z-probe as W axis endstop 
    G4 P20                                                                                     ; debounce
    echo move.axes[7].machinePosition
    G1 H{var.mode} W10 F{global.bed_lift_speed}                                                ; Move bed up and terminate move when z-probe endstop is triggered and update the current position
    M118 P0 S{"W screwjack Height measurement complete. Calculating Height Difference..."} L2
    M400
    G4 P20                                                                                     ; debounce
    echo move.axes[7].machinePosition
    set var.w_pos_diff = move.axes[7].machinePosition - var.w_pos
    echo var.w_pos_diff
    if var.w_pos_diff <= 0
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L1
        set global.bedtiltlevel = false
        M99
    M574 W0 S2                                                                                 ; disable Z-probe as W axis endstop
    G90                                                                                        ; absolute positioning
    M118 P0 S{"Resetting to W screwjack..."} L2
    G1 U{var.u_pos} V{var.v_pos} W{var.w_pos} C{var.c_pos} F{global.bed_lift_speed}            ; Move down
    M118 P0 S{"W screwjack Height measurement complete."} L2

    ; Tilt C screwjack
    M118 P0 S{"Moving gantry to C screwjack..."} L2
    G1 X{var.c_x} Y{var.c_y} F{global.tool_change_speed}                                       ; Move to C screwjack
    M118 P0 S{"Gantry at C screwjack."} L2
    M400
    G4 P20                                                                                     ; debounce
    if sensors.probes[0].value[0] > sensors.probes[0].threshold
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L3
        set global.bedtiltlevel = false
        M99
    G91                                                                                        ; relative positioning
    set var.c_pos = move.axes[8].machinePosition
    M574 C2 S2                                                                                 ; configure Z-probe as C axis endstop 
    G4 P20                                                                                     ; debounce
    echo move.axes[8].machinePosition
    G1 H{var.mode} C10 F{global.bed_lift_speed}                                                ; Move bed up and terminate move when z-probe endstop is triggered and update the current position
    M118 P0 S{"C screwjack Height measurement complete. Calculating Height Difference..."} L2
    M400
    G4 P20                                                                                     ; debounce
    echo move.axes[8].machinePosition
    set var.c_pos_diff = move.axes[8].machinePosition - var.c_pos
    echo var.c_pos_diff
    if var.c_pos_diff <= 0
        M18
        M118 P0 S"Bed Tilt Levelling Error. Check z-probe and bed screwjacks!" L3
        set global.bedtiltlevel = false
        M99
    M574 C0 S2                                                                                 ; disable Z-probe as C axis endstop
    G90                                                                                        ; absolute positioning
    M118 P0 S{"Resetting to C screwjack..."} L2
    G1 U{var.u_pos} V{var.v_pos} W{var.w_pos} C{var.c_pos} F{global.bed_lift_speed}            ; Move down
    M118 P0 S{"C screwjack Height measurement complete."} L2

    ; Tilt Compensation Calculations
    var min = min(var.u_pos_diff, var.v_pos_diff, var.w_pos_diff, var.c_pos_diff)
    set var.u_pos_adjust = var.u_pos_diff - var.min
    set var.v_pos_adjust = var.v_pos_diff - var.min
    set var.w_pos_adjust = var.w_pos_diff - var.min
    set var.c_pos_adjust = var.c_pos_diff - var.min
    echo "Bed Adjustments -- U:"^var.u_pos_adjust, "V:"^var.v_pos_adjust, "W:"^var.w_pos_adjust, "C:"^var.c_pos_adjust
    M400
    G4 P20                                                                                     ; debounce

    if max(var.u_pos_diff, var.v_pos_diff, var.w_pos_diff, var.c_pos_diff) - min(var.u_pos_diff, var.v_pos_diff, var.w_pos_diff, var.c_pos_diff) < var.bedthreshold
        break

    G91
    M118 P0 S{"Adjustting Bed screwjacks according to calculations..."} L2
    G1 U{var.u_pos_adjust} V{var.v_pos_adjust} W{var.w_pos_adjust} C{var.c_pos_adjust} F{global.bed_lift_speed}         ; adjust bed position
    M400
    echo "Bed Adjusted."
    G90

    set var.u_pos = move.axes[5].machinePosition
    set var.v_pos = move.axes[6].machinePosition
    set var.w_pos = move.axes[7].machinePosition
    set var.c_pos = move.axes[8].machinePosition

    set var.count = var.count + 1
    M400
    G4 P20                                                                                     ; debounce

; Save Bed Axes Homing Values
echo >"bedhomerestore.g" "G92 U"^move.axes[5].machinePosition^" V"^move.axes[6].machinePosition^" W"^move.axes[7].machinePosition^" C"^move.axes[8].machinePosition
echo >>"bedhomerestore.g" "set global.U_coor = "^move.axes[5].machinePosition
echo >>"bedhomerestore.g" "set global.V_coor = "^move.axes[6].machinePosition
echo >>"bedhomerestore.g" "set global.W_coor = "^move.axes[7].machinePosition
echo >>"bedhomerestore.g" "set global.C_coor = "^move.axes[8].machinePosition
set global.U_coor = move.axes[5].machinePosition
set global.V_coor = move.axes[6].machinePosition
set global.W_coor = move.axes[7].machinePosition
set global.C_coor = move.axes[8].machinePosition

G90
G1 X0 Y0 F{global.tool_change_speed}                                                           ; Move to middle
M564 S0
M208 S1 Y{global.tool_limit_y}                                                                 ; reset default axis limits
M208 S0 Y{global.ymax}                                                                         ; reset default axis limits
M400
G4 P20 ; debounce
G30 S-1                                                                                        ; probe bed for z-offset
M564 S1

M400
G4 P20 ; debounce
G1 Z{sensors.probes[0].diveHeights[0]} F720                                                    ; move z to dive height (10mm)

echo "Last Stop Height: "^sensors.probes[0].lastStopHeight
set var.bedfinaladjust = sensors.probes[0].triggerHeight - sensors.probes[0].lastStopHeight 
echo "Last Bed Adjustment: "^var.bedfinaladjust

G91
M118 P0 S{"Final Bed screwjack adjustments..."} L2
G1 U{var.bedfinaladjust} V{var.bedfinaladjust} F{global.bed_lift_speed}
G1 W{var.bedfinaladjust} C{var.bedfinaladjust} F{global.bed_lift_speed}
M118 P0 S{"Final Bed screwjack adjustments Complete."} L2
M400
G90

G60                                                                                            ; save current position to slot 0 (default)
M118 P0 S{"Bed Tilt Levelling Complete! Duration: "^(state.time-var.timer)^" seconds"} L2
set global.bedtiltlevel = true

G29                                                                                            ; probe with mesh bed level