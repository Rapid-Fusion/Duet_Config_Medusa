; daemon.g

while true
;    if global.probeoverride == false
;        if sensors.probes[0].value[0] > sensors.probes[0].threshold + 500 || sensors.probes[0].value[0] < 5000
;            M18
;            M118 P0 S"Z-probe Error. Check bed and z-probe!" L3
;            set global.bedtiltlevel = false
        
;    if move.axes[3].machinePosition > 0
;        M42 P3 S0 ; disable U endstop

;    if move.axes[4].machinePosition > 0
;        M42 P4 S0 ; disable V endstop

;    if move.axes[5].machinePosition > 0
;        M42 P5 S0 ; disable W endstop

    ; Motor Safety Contactor Logic - Prevent unintended holding of contactor
    ;if (state.gpOut[0].pwm == 1)
    ;    G4 P5000 ; debounce
    ;    if (state.gpOut[0].pwm == 1)
    ;        M118 P0 S"Uninteded holding of motor contactor. Motion System Disabled." L1
    ;        M42 P0 S0 ; disengage motor safety contactor
    ;        if exists(job.build) ; if job build exists
    ;            M0 H0 ; unconditional stop with heaters off

    ; Pause Print on Motion System/Spindle STO Fault
    if global.printing == true && sensors.gpIn[20].value == 0 ; Machine Printing & safety system OFF
        set global.printing = false
        M25 ; pause print
        M5 ; disable spindle
        M18 ; disable motors
        set global.home = false
        M118 P0 S"Motion System/Spindle STO Fault. Print Paused..." L1

    ; Check & set global home state
    if (global.x_motors_homed == false || global.y_motors_homed == false || global.z_motors_homed == false)
        set global.home = false

    ; Check Tool Changer Pistons
    if (sensors.gpIn[0].value == 0 && sensors.gpIn[1].value == 1) ; IF UNLOCKED
        set global.toolChangerPistonState = "Unlocked"
    elif (sensors.gpIn[0].value == 1 && sensors.gpIn[1].value == 0) ; IF LOCKED
        set global.toolChangerPistonState = "Locked"
    else
        G4 P200 ; debounce
        if (sensors.gpIn[0].value == 0 && sensors.gpIn[1].value == 0) || (sensors.gpIn[0].value == 1 && sensors.gpIn[1].value == 1)
            M18 ; Disable all motors
            set global.toolChangerPistonState = "Fault"
            M98 P"Pellet Feed DISABLE.g"
            if exists(job.build) ; if job build exists
                M0 H0 ; unconditional stop with heaters off

            ; display message every 60 seconds
            if state.time > global.solenoid_timer
                M118 P0 S"Tool Changer solenoid failure. Check piston position and compressor air pressure." L1
                M118 P0 S{"Tool Changer Piston Sensor (TOP): "^(sensors.gpIn[0].value)^" | Tool Changer Piston Sensor (BOTTOM): "^(sensors.gpIn[1].value)^" | 0 = Inactive, 1 = Active"} L1 ; WARNING
                set global.solenoid_timer = state.time + 60

    ; Machine LED states --------------------------
    if state.status == "processing" ; printing
        M98 P"LED_Purple.g"
        ; Door Button LED - PURPLE
        M42 P14 S1 ; R
        M42 P15 S0 ; G
        M42 P16 S1 ; B
    elif state.status == "paused" || state.status == "pausing" || state.status == "resuming" ; print paused
        M98 P"LED_Amber.g"
        ; Door Button LED - AMBER
        M42 P14 S1 ; R
        M42 P15 S1 ; G
        M42 P16 S0 ; B
    elif global.toolchangeready == false || global.toolChangerPistonState = "Fault"
        M98 P"LED_MachineFault.g"
        ; Door Button LED - RED
        M42 P14 S1 ; R
        M42 P15 S0 ; G
        M42 P16 S0 ; B
    elif (state.status == "idle" && sensors.gpIn[20].value == 0) || (state.status == "busy" && sensors.gpIn[20].value == 0) ; IF system IDLE & Safety System is OFF
        ; Auto Doors ----------------------------------
        if global.homing = true ; when homing
            M581 T6 P19 S-1 R0 ; disable trigger 6 during homing
        else
            M581 T6 P19 S0 R0 ; invoke trigger 6 when an active-to-inactive edge is detected on input 19
        if global.doorButtonPressed == false
            ; Door Button LED - GREEN
            M42 P14 S0 ; R
            M42 P15 S1 ; G
            M42 P16 S0 ; B
    else ; default
        M98 P"LED_White.g"
        M581 T6 P19 S-1 R0 ; disable trigger 6
        ; Door Button LED - RED
        M42 P14 S1 ; R
        M42 P15 S0 ; G
        M42 P16 S0 ; B

    ; Pellet Tool --------------------------------------------------------------------
    
    ; [TEMP] Material feeding sensor -- Loop every 10 seconds
    ;if (state.time - global.materialfeedtimer > 30)
    ;    M42 P3 S1 ; Open pellet feeding solenoid
    ;    G4 P2000  ; Boost pellets for 2 seconds
    ;    M42 P3 S0 ; Close pellet feeding solenoid
    ;    set global.materialfeedtimer = state.time

    ; [OLD] Material feeding sensor
    ;if (global.materialsensor == true && state.time - global.materiallooptimer > 5) ; Loop every 5 seconds
    ;    if sensors.gpIn[2].value == 0 ; no material
    ;        if (state.time > global.materialfeedtimer + 2) ; Boost Pellets for 2 seconds
    ;            M42 P3 S1 ; Open pellet feeding solenoid
    ;            set global.materialfeedtimer = state.time
    ;        else
    ;            M42 P3 S0 ; Close pellet feeding solenoid
    ;            set global.materiallooptimer = state.time
    ;    else
    ;        M42 P3 S0 ; Close pellet feeding solenoid

    ; Material feeding sensor
    ;if sensors.gpIn[2] !== null
    ;    if sensors.gpIn[2].value == 0 ; no material
    ;        if (state.time - global.materialfeedtimer > global.materialcalldelay) ; Pellet demand exceeds 25 seconds
    ;            set global.materialfeedtimer = state.time
    ;            M118 P0 S"Refill Pellet Hopper or check for clogging at extruder barrel inlet!" L1
    ;            if exists(job.build) ; if job build exists
    ;                M25 ; pause print
    ;    else
    ;        set global.materialfeedtimer = state.time

    ; Filament Tool --------------------------------------------------------------------
    if exists(job.build)
        if state.currentTool == 2 && sensors.gpIn[17].value == 0 && global.filLEFTDetection == true
            M118 P0 S"No Filament Detected in Filament Chamber LEFT! Please reload!" L1
            M25 ; pause print

        if state.currentTool == 3 && sensors.gpIn[18].value == 0 && global.filRIGHTDetection == true
            M118 P0 S"No Filament Detected in Filament Chamber RIGHT! Please reload!" L1
            M25 ; pause print

    ; Filament Chamber Buttons
    if state.status == "idle" || state.status == "paused"
        M98 P"enablefildetection.g" ; Enable Filament Loading/Unloading

    G4 P500 ; loop every 500 ms

