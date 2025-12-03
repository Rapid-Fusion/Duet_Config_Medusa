; daemon.g

while true

    ; Tool Changing -----------------------------------------------------------------------------------

    ; Check Tool Changer Pistons
    if (sensors.gpIn[0].value == 0 && sensors.gpIn[1].value == 1) ; IF UNLOCKED
        set global.toolChangerPistonState = "Unlocked"
    elif (sensors.gpIn[0].value == 1 && sensors.gpIn[1].value == 0) ; IF LOCKED
        set global.toolChangerPistonState = "Locked"
    else
        G4 P20 ; debounce
        if (sensors.gpIn[0].value == 0 && sensors.gpIn[1].value == 0) || (sensors.gpIn[0].value == 1 && sensors.gpIn[1].value == 1)
            ;M18 ; Disable all motors
            ;set global.toolChangerPistonState = "Fault"

            ; display message every 60 seconds
            if state.time > global.solenoid_timer
                ;M98 P"Pellet Feed DISABLE.g"
                M118 P0 S"WARNING: Tool Changer solenoid fault or interference. Check piston position and compressor air pressure." L1
                M118 P0 S{"Tool Changer Piston Sensor (TOP): "^(sensors.gpIn[0].value)^" | Tool Changer Piston Sensor (BOTTOM): "^(sensors.gpIn[1].value)^" | 0 = Inactive, 1 = Active"} L1 ; WARNING
                set global.solenoid_timer = state.time + 60

            ;if exists(job.build) ; if job build exists
                ;M25 ; pause print
                ;M118 P0 S"Print Paused. Resolve before continuing print!!!" L1
                ;M0 ; unconditional stop with heaters off


    ; Pellet Tool --------------------------------------------------------------------
    if sensors.gpIn[5].value == 1 ; Siemens Pellet Feed Fault
        if exists(job.build)
            M25 ; pause print
            M118 P0 S"Empty dryer or clogged filters on pellet tool." L1
            M118 P0 S"Clear errors in manual pellet feed mode and refill tool hopper before resuming print!" L1
        else
            M118 P0 S"Empty dryer or clogged filters on pellet tool." L1
            M118 P0 S"Clear errors in manual pellet feed mode and refill tool hopper" L1

    ; When print is not running & below 40 deg, turn fans to silent
    if !exists(job.build)
        if heat.heaters[0].current == 2000 || heat.heaters[1].current == 2000 || heat.heaters[2].current == 2000 || heat.heaters[3].current == 2000
            if global.fanspeed != "Default"
                M98 P"FansDefault.g"
        else
            if heat.heaters[0].current > 40 || heat.heaters[1].current > 40 || heat.heaters[2].current > 40 || heat.heaters[3].current > 40
                if global.fanspeed != "MAX"
                    M98 P"FansMax.g"
            else
                if global.fanspeed != "Default"
                    M98 P"FansDefault.g"

    ; Filament Tool --------------------------------------------------------------------
    
    ; Enable Filament Loading on Idle/Paused states
    if state.status == "idle" || state.status == "paused"
        M98 P"enablefildetection.g" ; Enable Filament Loading/Unloading

    ; Filament Run-out
    if exists(job.build)
        if state.currentTool == 2 && sensors.gpIn[17].value == 0 && global.filLEFTDetection == true
            M25 ; pause print
            if state.time > global.timer_1
                M118 P0 S"No Filament Detected in Filament Chamber LEFT! Please reload!" L1
                set global.timer_1 = state.time + 60

        if state.currentTool == 3 && sensors.gpIn[18].value == 0 && global.filRIGHTDetection == true
            M25 ; pause print
            if state.time > global.timer_2
                M118 P0 S"No Filament Detected in Filament Chamber RIGHT! Please reload!" L1
                set global.timer_2 = state.time + 60


    ; Axes Homed Check ------------------------------------------------------------------
    if global.print_homed == true
        if move.axes[0].homed == false || move.axes[1].homed == false || move.axes[2].homed == false
            set global.home = false
            if exists(job.build)
                M25 ; pause print
                if state.time > global.timer_3
                    M118 P0 S"Axes Not Homed. Print Paused..." L1
                    set global.timer_3 = state.time + 60
                    set global.print_homed = false


    ; Machine LED states --------------------------
    if state.status == "processing" ; printing
        M98 P"LED_Purple.g"
    elif state.status == "paused" || state.status == "pausing" || state.status == "resuming" ; print paused
        M98 P"LED_Amber.g"
    elif global.toolchangeready == false || global.toolChangerPistonState = "Fault"
        M98 P"LED_MachineFault.g"
    else ; default
        M98 P"LED_White.g"


    G4 P500 ; loop every 500 ms

