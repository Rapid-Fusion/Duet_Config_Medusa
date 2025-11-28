; ALU Bed (Default)
G31 P2174 K0 X0 Y0 Z5 T0 S22.2 H10 ; define probe 0 offsets (X,Y), probe no (K), trigger value (P) and trigger height (Z), tempeature coefficient (T), calibration temperature (S), temp sensor no. (H)
M558.2 K0 S20 R188387              ; set drive current and reading offset (M558.2 K0 S-1)

; Need to ALTER Pellet, Filament & CNC offsets!!!