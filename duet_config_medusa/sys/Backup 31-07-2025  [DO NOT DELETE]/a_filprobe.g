; SuperPINDA probe on LEFT extruder

G29 S2 ; clear mesh compensation
M290 R0 S0 ; reset babystepping

G53 G1 X0 Y0 F7200 ; move to middle 
G1 Z100 F7200 ; move Z close to bed
G1 Z{sensors.probes[2].diveHeights[0]} F1800 ; move z to probe dive height (10mm)

var initial_z_offset = tools[2].offsets[2]

M118 P0 S{"Initial tool Z-offset: "^var.initial_z_offset^"mm"} L2

G30 K2 S-2                                  ; probes and adjusts the tool Z offset to make the actual stop height match the configured value. A tool must be selected first when using G30 S-2.

M400
G4 P20

var new_z_offset = tools[2].offsets[2]
M118 P0 S{"New tool Z-offset: "^var.new_z_offset^"mm"} L2

var diff = var.initial_z_offset - var.new_z_offset
if var.diff > 0
    M118 P0 S{"Tool Head moved DOWN by "^var.diff^"mm"} L2
elif var.diff < 0
    M118 P0 S{"Tool Head moved UP by "^-var.diff^"mm"} L2
else
    M118 P0 S{"Tool Head has not moved"} L2

G1 Z{sensors.probes[2].diveHeights[0]} F720 ; move z back up to probe dive height (10mm)