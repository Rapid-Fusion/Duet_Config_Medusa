; ProbeSpindle.g

M118 P0 S"Spindle Probing Initialised..." L2

;if global.home == false
;    G28                                                      ; home

M568 P0 R0 A0                                                ; Set pellet tool preheat (standby) temps to 0 deg & OFF
T1                                                           ; Select Spindle
M5                                                           ; stop spindle

M208 S1 Y{global.tool_setter_y}                              ; Tool Setter Limits
G53 G1 Z{global.tool_setter_z_ready} F2000                   ; Move to Probe Ready Height
G53 G1 X{global.tool_setter_x} Y{global.tool_setter_y} F7200 ; Move to Probe Ready Position

; Probe the bed and set the Z probe trigger height to the height it stopped at
G30 K1 S-3                                                   ; Single Z-Probe -- Probe tool setter with probe 1
M400
G4 P20                                                       ; debounce

;G10 L1 P1 X0 Y0 Z{move.axes[2].machinePosition}          ; Set Spindle Tool Offset

G91
G53 G1 Z10 F720 ; move up
G90
G53 G1 Y{global.tool_limit_y} F7200                          ; Move back to Tool Limits
M208 S1 Y{global.tool_limit_y}                               ; Reset Limits

M118 P0 S{"Trigger Height: "^{move.axes[2].machinePosition}} L2
M118 P0 S"Spindle Probing Complete!" L2