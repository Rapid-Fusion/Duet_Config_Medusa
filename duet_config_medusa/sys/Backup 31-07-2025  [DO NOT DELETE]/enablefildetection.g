; enablefildetection.g

if sensors.gpIn[17].value == 0 ; filament LEFT NOT detected
    ; enable insertion
    M581 T2 P13 S0 R0
    M42 P10 S0 ; GREEN Button
else ; filament LEFT Detected
    ; disable insertion
    M581 T2 P-1
    M42 P10 S1 ; WHITE Button

if sensors.gpIn[18].value == 0 ; filament RIGHT NOT detected
    ; enable insertion
    M581 T4 P15 S0 R0
    M42 P12 S0 ; GREEN Button
else ; filament RIGHT Detected
    ; disable insertion
    M581 T4 P-1
    M42 P12 S1 ; WHITE Button

; Enable Retraction
M581 T3 P14 S0 R0
M581 T5 P16 S0 R0

; Fil Button LEDS - Green
M42 P11 S0
M42 P13 S0