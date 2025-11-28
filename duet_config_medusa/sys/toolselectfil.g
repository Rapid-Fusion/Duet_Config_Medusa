; selectfil.g

G28 ; MUST home
T0 ; select filament tool

G1 X0 Y0 F72000
G1 Z500 F7200 ; move down to ergonomic position for maintenance
M208 Y-690:690
G1 X0 Y-690 F7200
M208 Y-385:690

M98 P"disable_triggers.g"
M18 X Y Z
M98 P"enable_triggers.g"