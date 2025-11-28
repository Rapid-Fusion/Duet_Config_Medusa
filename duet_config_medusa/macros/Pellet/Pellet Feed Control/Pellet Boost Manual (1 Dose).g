; Pellet Boost Manual (1 Dose).g

M118 P0 S"Manual Pellet Boosting..." L2

; Toggle Pellet Boost
M42 P3 S1
G4 S1
M42 P3 S0

G4 S7

M118 P0 S"Manual Pellet Boost Complete (1 Dose)!" L2

;if state.currentTool == 0 ; pellet tool selected
;    M118 P0 S"Pellet Boost Complete!" L2
;else
;    M118 P0 S"Select Pellet Tool first before requesting pellets!" L1 ; WARNING