; DO NOT RUN (reference only) -- TunePelletExtruder.g 

; TO BE IMPLEMENTED IN USER INTERFACE BACKEND

;T0 P0 ; select Pellet Extruder without tool changing
M568 P0 R0:0:0:0 S0:0:0:0 A1 ; All heaters preheat

; Start Tuning Sequence
M303 H0 P1 A{heat.heaters[0].current} S250 Q1 F0.7 ; Tune Top Heater to 250 deg C
while heat.heaters[0].state = "tuning"
    G4 S1
M500 ; Save tuning params to config-override.g
M501 ; Run config-override.g
G4 P20 ; debounce
M568 P0 R150:0:0:0 S150:0:0:0 A1 ; Preheat Top Heater to 150 deg
M116 P0 H0 S5 ; Wait for Top Temp to be reached

M303 H1 P1 A{heat.heaters[1].current} S300 Q1 F0.7 ; Tune Middle Heater to 300 deg C
while heat.heaters[1].state = "tuning"
    G4 S1
M500 ; Save tuning params to config-override.g
M501 ; Run config-override.g
G4 P20 ; debounce
M568 P0 R150:150:0:0 S150:150:0:0 A1 ; Preheat Middle Heater to 300 deg
M116 P0 H1 S5 ; Wait for Middle Temp to be reached

M303 H2 P1 A{heat.heaters[2].current} S300 Q1 F0.7 ; Tune Bottom Heater to 300 deg C
while heat.heaters[2].state = "tuning"
    G4 S1
M500 ; Save tuning params to config-override.g
M501 ; Run config-override.g
G4 P20 ; debounce
M568 P0 R150:150:150:0 S150:150:150:0 A1 ; Preheat Bottom Heater to 300 deg
M116 P0 H2 S5 ; Wait for Bottom Temp to be reached

M303 H3 P1 A{heat.heaters[3].current} S300 Q1 F0.7 ; Tune Nozzle Heater to 300 deg C
while heat.heaters[3].state = "tuning"
    G4 S1
M500 ; Save tuning params to config-override.g
M501 ; Run config-override.g

M118 S"PE320 Extruder Tuning Complete - All heaters off."
M568 P0 R0:0:0:0 S0:0:0:0 A0 ; All heaters off

;T T{state.previousTool} P0 ; select previous tool without tool changing

