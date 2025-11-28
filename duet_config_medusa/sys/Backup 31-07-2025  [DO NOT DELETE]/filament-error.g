; filament-error.g
; Runs upon filament run-out/jamming detected

if param.D == 2
    M118 L1 P0 S"Warning: filament run-out/jam on Filament extruder LEFT. Please check corresponding Bondtech extruder"
    ;if global.checkfilLEFT == "enabled"
    ;    M118 L1 P0 S"Warning: No filament at LEFT Bondtech extruder. Please INSERT filament before printing!"
    ;    M291 S2 P"Warning: No filament at LEFT Bondtech extruder. Please INSERT filament before printing!"
elif param.D == 4
    M118 L1 P0 S"Warning: filament run-out/jam on Filament extruder RIGHT. Please check corresponding Bondtech extruder"
    ;if global.checkfilRIGHT == "enabled"
    ;    M118 L1 P0 S"Warning: No filament at RIGHT Bondtech extruder. Please INSERT filament before printing!"
    ;    M291 S2 P"Warning: No filament at RIGHT Bondtech extruder. Please INSERT filament before printing!"
else
    M118 L1 P0 S"Warning: filament run-out/jam on null extruder. Check Filament Drive Mapping is BONDTECH"
