;M568 P0 A2 ; set tool 0 to active
;M568 P1 A2 ; set tool 1 to active
;M116 S5 ; wait for temperatures

G28 ; Home

M83 ; relative extrusion
;G1 E10 F1000 ; undo the retraction that was done in the M911 power fail script
