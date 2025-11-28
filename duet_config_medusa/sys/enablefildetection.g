; enablefildetection.g

;if sensors.gpIn[17].value == 0 ; filament LEFT NOT detected
;    M581 T2 P13 S0 R0 ; enable insertion
;else ; filament LEFT Detected
;    M581 T2 P-1 ; disable insertion

;if sensors.gpIn[18].value == 0 ; filament RIGHT NOT detected
;    M581 T4 P15 S0 R0 ; enable insertion
;else ; filament RIGHT Detected
;    M581 T4 P-1 ; disable insertion

; Enable Loading
M581 T2 P13 S0 R0
M581 T4 P15 S0 R0

; Enable Unloading
M581 T3 P14 S0 R0
M581 T5 P16 S0 R0
