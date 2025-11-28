; Variables

; Print Variables -----------------------------------------------------------------------------------------------------------------------
if !exists(global.printing)
	global printing = false                    
else
	set global.printing = false

; AiBuild Print Use
if !exists(global.print_layer)
	global print_layer = 0                                   
else
	set global.print_layer = 0  

; Bead Snapshot
if !exists(global.beadSnapshotHeight)
	global beadSnapshotHeight = 300                                   
else
	set global.beadSnapshotHeight = 300

; Check home status during print
if !exists(global.print_homed)
	global print_homed = false                                   
else
	set global.print_homed = false

; Require bed mesh level on startup
if !exists(global.first_mesh)
	global first_mesh = false                                   
else
	set global.first_mesh = false

; Logging ---------------------------------------------------------------------------------------------------------------------------------------------
if !exists(global.logMessage)
	global logMessage = ""                                    
else
	set global.logMessage = ""                                

; Timers ---------------------------------------------------------------------------------------------------------------------------------------------
if !exists(global.solenoid_timer)
	global solenoid_timer = state.time                                     
else
	set global.solenoid_timer = state.time                                

if !exists(global.materiallooptimer)
	global materiallooptimer = state.time                                  
else
	set global.materiallooptimer = state.time

if !exists(global.materialfeedtimer)
	global materialfeedtimer = state.time                                  
else
	set global.materialfeedtimer = state.time                                

if !exists(global.safety_timer)
	global safety_timer = state.time                                       
else
	set global.safety_timer = state.time                                   

if !exists(global.timer)
	global timer = state.time                                                
else
	set global.timer = state.time       

if !exists(global.timer_1)
	global timer_1 = state.time                                                
else
	set global.timer_1 = state.time       

if !exists(global.timer_2)
	global timer_2 = state.time                                                
else
	set global.timer_2 = state.time       

if !exists(global.timer_3)
	global timer_3 = state.time                                                
else
	set global.timer_3 = state.time       

if !exists(global.timer_4)
	global timer_4 = state.time                                                
else
	set global.timer_4 = state.time       

if !exists(global.timer_5)
	global timer_5 = state.time                                                
else
	set global.timer_5 = state.time     

if !exists(global.timer_6)
	global timer_6 = state.time                                                
else
	set global.timer_6 = state.time    

; Motor Homing Motion System -----------------------------------------------------------------------------------------------------------------------
if !exists(global.home)
	global home = false
else
	set global.home = false

if !exists(global.x_motors_homed)
	global x_motors_homed = false
else
	set global.x_motors_homed = false

if !exists(global.y_motors_homed)
	global y_motors_homed = false
else
	set global.y_motors_homed = false

if !exists(global.z_motors_homed)
	global z_motors_homed = false
else
	set global.z_motors_homed = false

; Tool Changer -------------------------------------------------------------------------------------------------------------------
if !exists(global.tool_change_speed)
	global tool_change_speed = 7200
else
	set global.tool_change_speed = 7200

if !exists(global.toolChangerPistonState)
	global toolChangerPistonState = "null"
else
	set global.toolChangerPistonState = "null"

if !exists(global.tool)
	global tool = "none"
else
	set global.tool = "none"

if !exists(global.toolchangeready)
	global toolchangeready = true                                          
else
	set global.toolchangeready = true                                      

if !exists(global.no_tool_handshake)
	global no_tool_handshake = "received"
else
	set global.no_tool_handshake = "received"

if !exists(global.pellet_tool_handshake)
	global pellet_tool_handshake = "received"
else
	set global.pellet_tool_handshake = "received"

if !exists(global.spindle_tool_handshake)
	global spindle_tool_handshake = "received"
else
	set global.spindle_tool_handshake = "received"

if !exists(global.filament_tool_handshake)
	global filament_tool_handshake = "received"
else
	set global.filament_tool_handshake = "received"

; Bed Tilt Levelling & Mesh Scanning -------------------------------------------------------------------------------------------------------------------
if !exists(global.bedready)
	global bedready = true
else
	set global.bedready = true

if !exists(global.probeoverride)
	global probeoverride = false
else
	set global.probeoverride = false

if !exists(global.zmin)
	global zmin = 0                                                        ; Z=3 to prevent crashing during DEV
else
	set global.zmin = 0

if !exists(global.framezheight)
	global framezheight = 1205
else
	set global.framezheight = 1205

if !exists(global.bed_tilt_height)
	global bed_tilt_height = 18                                            ; (22 - ALU, 18 - CF)
else
	set global.bed_tilt_height = 18                                        ; (22 - ALU, 18 - CF)

if !exists(global.bed_lift_speed)
	global bed_lift_speed = 50
else
	set global.bed_lift_speed = 50

if !exists(global.bedSurfaceCurrent)
	global bedSurfaceCurrent = "ALU"                                       ; Bed Surface Types -- ALU, CF
else
	set global.bedSurfaceCurrent = "ALU"                                   ; Bed Surface Types -- ALU, CF

; Filament Change -------------------------------------------------------------------------------------------------------------------
if !exists(global.filLEFTstatus)
	global filLEFTstatus = false
else
	set global.filLEFTstatus = false

if !exists(global.filRIGHTstatus)
	global filRIGHTstatus = false
else
	set global.filRIGHTstatus = false

; Filament Tool -------------------------------------------------------------------------------------------------------------------
if !exists(global.partcoolingfactorLEFT)
	global partcoolingfactorLEFT = 1
else
	set global.partcoolingfactorLEFT = 1

if !exists(global.partcoolingfactorRIGHT)
	global partcoolingfactorRIGHT = 1
else
	set global.partcoolingfactorRIGHT = 1                              

if !exists(global.checkfilLEFT)
	global checkfilLEFT = "disabled"
else
	set global.checkfilLEFT = "disabled"

if !exists(global.checkfilRIGHT)
	global checkfilRIGHT = "disabled"
else
	set global.checkfilRIGHT = "disabled"

if !exists(global.filLEFTDetection)
	global filLEFTDetection = false
else
	set global.filLEFTDetection = false

if !exists(global.filRIGHTDetection)
	global filRIGHTDetection = false
else
	set global.filRIGHTDetection = false

if !exists(global.filLEFTExtend)
	global filLEFTExtend = 10
else
	set global.filLEFTExtend = 10  

if !exists(global.filRIGHTExtend)
	global filRIGHTExtend = 10
else
	set global.filRIGHTExtend = 10  

if !exists(global.nozzleprobe)
	global nozzleprobe = false
else
	set global.nozzleprobe = false  

; Pellet Tool ---------------------------------------------------------------------------------------------------------------------------------
if !exists(global.materialsensor)
	global materialsensor = true
else
	set global.materialsensor = true

if !exists(global.fanspeed)
	global fanspeed = "Default"
else
	set global.fanspeed = "Default"

; Spindle Tool ---------------------------------------------------------------------------------------------------------------------------------
if !exists(global.tool_setter_x)
	global tool_setter_x = -595
else
	set global.tool_setter_x = -595

if !exists(global.tool_setter_y)
	global tool_setter_y = -514
else
	set global.tool_setter_y = -514

if !exists(global.tool_setter_z_ready)
	global tool_setter_z_ready = 140
else
	set global.tool_setter_z_ready = 140

; Tool Docking  -------------------------------------------------------------------------------------------------------------------------------
if !exists(global.scoop_zheight)
	global scoop_zheight = 1.5
else
	set global.scoop_zheight = 1.5

if !exists(global.scoop_ydist)
	global scoop_ydist = 25
else
	set global.scoop_ydist = 25

if !exists(global.xmax)
	global xmax = 646
else
	set global.xmax = 646

if !exists(global.xmin)
	global xmin = -646
else
	set global.xmin = -646

if !exists(global.tool_limit_y)
	global tool_limit_y = -389
else
	set global.tool_limit_y = -389

if !exists(global.ymax)
	global ymax = 411
else
	set global.ymax = 411

if !exists(global.tool_accel_y)
	global tool_accel_y = 1500                                             ; mm/s^2
else
	set global.tool_accel_y = 1500                                         ; mm/s^2

if !exists(global.accel_xy)
	global accel_xy = 1500                                                 ; mm/s^2
else
	set global.accel_xy = 1500                                             ; mm/s^2

; Pellet Tool Coordinates
if !exists(global.pellet_x)
	global pellet_x = -300
else
	set global.pellet_x = -300

if !exists(global.pellet_y_top)
	global pellet_y_top = -695.5
else
	set global.pellet_y_top = -695.5

if !exists(global.pellet_y_bottom)
	global pellet_y_bottom = -697
else
	set global.pellet_y_bottom = -697

if !exists(global.pellet_z_dock)
	global pellet_z_dock = 1197 + (global.framezheight-1205)               ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]
else
	set global.pellet_z_dock = 1197 + (global.framezheight-1205)           ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]

if !exists(global.pellet_z_pickup)
	global pellet_z_pickup = 1185.5 + (global.framezheight-1205)             ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]
else
	set global.pellet_z_pickup = 1185.5 + (global.framezheight-1205)         ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]

; CNC Spindle Coordinates
if !exists(global.cnc_x)
	global cnc_x = -0.3
else
	set global.cnc_x = -0.3

if !exists(global.cnc_y_top)
	global cnc_y_top = -695.5
else
	set global.cnc_y_top = -695.5

if !exists(global.cnc_y_bottom)
	global cnc_y_bottom = -696.5
else
	set global.cnc_y_bottom = -696.5

if !exists(global.cnc_z_dock)
	global cnc_z_dock = 1200.5 + (global.framezheight-1205)                  ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]
else
	set global.cnc_z_dock = 1200.5 + (global.framezheight-1205)              ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]

if !exists(global.cnc_z_pickup)
	global cnc_z_pickup = 1189 + (global.framezheight-1205)                ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]
else
	set global.cnc_z_pickup = 1189 + (global.framezheight-1205)            ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]

; Filament Tool Coordinates
if !exists(global.filament_x)
	global filament_x = 299.8
else
	set global.filament_x = 299.8

if !exists(global.filament_y_top)
	global filament_y_top = -694.5
else
	set global.filament_y_top = -694.5

if !exists(global.filament_y_bottom)
	global filament_y_bottom = -695.5
else
	set global.filament_y_bottom = -695.5

if !exists(global.filament_z_dock)
	global filament_z_dock = 1200 + (global.framezheight-1205)             ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]
else
	set global.filament_z_dock = 1200 + (global.framezheight-1205)         ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]

if !exists(global.filament_z_pickup)
	global filament_z_pickup = 1188.5 + (global.framezheight-1205)           ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]
else
	set global.filament_z_pickup = 1188.5 + (global.framezheight-1205)       ; allow for dynamic frameheight adjustment [ONLY CHANGE FRONT NUM]

; Tool Offsets
if !exists(global.pellet_offset)
	global pellet_offset = -26.75                                          ; (10mm nozzle) ;-27.75 (5mm nozzle)
else
	set global.pellet_offset = -26.75                                      ; (10mm nozzle) ;-27.75 (5mm nozzle)

; Tool Bit
if !exists(global.cnc_offset)
	global cnc_offset = -97.797                                            ;-91                                                ;16mm ballnose
else
	set global.cnc_offset = -97.797                                        ;-91                                            ;16mm ballnose                                      

if !exists(global.filament_LEFT_offset)
	global filament_LEFT_offset = -10
else
	set global.filament_LEFT_offset = -10

if !exists(global.filament_RIGHT_offset)
	global filament_RIGHT_offset = -9
else
	set global.filament_RIGHT_offset = -9

; Bed
if !exists(global.U_coor)
	global U_coor = 0
else
	set global.U_coor = 0

if !exists(global.V_coor)
	global V_coor = 0
else
	set global.V_coor = 0

if !exists(global.W_coor)
	global W_coor = 0
else
	set global.W_coor = 0

if !exists(global.C_coor)
	global C_coor = 0
else
	set global.C_coor = 0

; Auto Doors
if !exists(global.doorButtonPressed)
	global doorButtonPressed = false
else
	set global.doorButtonPressed = false

if !exists(global.programRunning)
	global programRunning = false
else
	set global.programRunning = false

if !exists(global.homing)
	global homing = false
else
	set global.homing = false

; Filament Loading/Unloading
if !exists(global.loadspeed)
	global loadspeed = 14000
else
	set global.loadspeed = 14000

if !exists(global.loadlength)
	global loadlength = 8000
else
	set global.loadlength = 8000

if !exists(global.loadtoptemp)
	global loadtoptemp = 180
else
	set global.loadtoptemp = 180

if !exists(global.loadbottomtemp)
	global loadbottomtemp = 220
else
	set global.loadbottomtemp = 220

if !exists(global.filpurgebin_x)
	global filpurgebin_x = 596
else
	set global.filpurgebin_x = 596

if !exists(global.filpurgebin_y)
	global filpurgebin_y = -613
else
	set global.filpurgebin_y = -613

; Temperature Presets
if !exists(global.Fil_PETG_GF)
	global Fil_PETG_GF = 230
else
	set global.Fil_PETG_GF = 230

M118 P0 S"Global Variables Initialised!" L2