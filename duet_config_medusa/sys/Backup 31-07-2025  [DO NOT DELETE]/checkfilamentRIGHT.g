; checkfilamentRIGHT.g

if sensors.gpIn[18].value == 0 ; no filament present OR disconnected
    set global.filRIGHTstatus = false
    M118 L1 P0 R"WARNING" S"No filament at RIGHT Bondtech extruder or faulty sensor. Please INSERT filament before printing!"
    M291 R"WARNING" P"No filament at RIGHT Bondtech extruder or faulty sensor. INSERT RIGHT filament?" K{"OK","Cancel"} S4
    if (input == 0) ; OK selected
        M98 P"insertfilamentRIGHT.g"
else
    set global.filRIGHTstatus = true
    M118 L1 P0 S"Filament present in RIGHT filament extruder."

;G90
;M83
;T1 P0 ; select tool
;M568 A0 ; state OFF
;M302 P1 ; allow cold extrude
;set global.checkfilRIGHT = "enabled"
;G4 P200 ; debounce
;M409 K"global.checkfilRIGHT"
;G1 E0:10 F1000 ; extrude Bondtech ONLY to test filament presence
;G4 P200 ; debounce
;set global.checkfilRIGHT = "disabled"
;G4 P200 ; debounce
;G1 E0:-10 F1000 ; retract Bondtech
;M302 P0 ; disable cold extrude
;T-1 P0 ; deselect tool
;M568 P1 A0 ; state OFF