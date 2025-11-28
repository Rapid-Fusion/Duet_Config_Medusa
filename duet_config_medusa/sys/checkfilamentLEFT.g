; checkfilamentLEFT.g

if sensors.gpIn[17].value == 0 ; no filament present OR disconnected
    set global.filLEFTstatus = false
    M118 L1 P0 R"WARNING" S"No filament at LEFT Bondtech extruder or faulty sensor. Please INSERT filament before printing!"
    M291 R"WARNING" P"No filament at LEFT Bondtech extruder or faulty sensor. INSERT LEFT filament?" K{"OK","Cancel"} S4
    if (input == 0) ; OK selected
        M98 P"insertfilamentLEFT.g"
else
    set global.filLEFTstatus = true
    M118 L1 P0 S"Filament present in LEFT filament extruder."

;G90
;M83
;T0 P0 ; select tool
;M568 A0 ; state OFF
;M302 P1 ; allow cold extrude
;set global.checkfilLEFT = "enabled"
;G4 P200 ; debounce
;M409 K"global.checkfilLEFT"
;M400
;G1 E0:10 F1000 ; extrude Bondtech ONLY to test filament presence
;G4 P200 ; debounce
;set global.checkfilLEFT = "disabled"
;M400
;G4 P200 ; debounce
;G1 E0:-10 F1000 ; retract Bondtech
;M302 P0 ; disable cold extrude
;T-1 P0 ; deselect tool
;M568 P0 A0 ; state OFF
