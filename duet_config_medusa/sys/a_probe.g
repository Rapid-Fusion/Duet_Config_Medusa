T-1 ; deselect tools

var gantryheight = sensors.probes[0].diveHeights[0]                  ; 10mm dive height
var triggerdiff = var.gantryheight - sensors.probes[0].triggerHeight ; 10mm dive - 6mm trigger (CF) OR 10mm dive - 5mm trigger (ALU)
var triggerheightactual = move.axes[2].machinePosition
var zadjust = 0

G90
G1 Y0 F7200
G1 X0 F7200
G1 Z100 F7200
G1 Z10 F1800

M118 P0 S{"Probing Bed... (Initial)"} L2
G30 S-1                                                              ; probe bed
G4 P20                                                               ; debounce
set var.triggerheightactual = move.axes[2].machinePosition
echo "Theoretical Dive Height: "^sensors.probes[0].diveHeights[0]^" mm | Sensed Dive Height: "^(var.triggerheightactual+var.triggerdiff)^" mm"   
M400
G4 P20                                                               ; debounce

;G92 Z{sensors.probes[0].triggerHeight}                               ; set Z-height to theoretical trigger height (6mm for CF, 5mm for ALU)
G1 Z{sensors.probes[0].diveHeights[0]} F720                          ; move z back to dive height (10mm)

M400
G4 P20                                                               ; debounce
M118 P0 S{"Probing Bed... (Confirmation)"} L2
G30 S-1                                                              ; probe bed
G4 P20                                                               ; debounce
set var.triggerheightactual = move.axes[2].machinePosition
echo "Theoretical Dive Height: "^sensors.probes[0].diveHeights[0]^" mm | Sensed Dive Height: "^(var.triggerheightactual+var.triggerdiff)^" mm"

G1 Z{sensors.probes[0].diveHeights[0]} F720                          ; move z back to dive height (10mm)