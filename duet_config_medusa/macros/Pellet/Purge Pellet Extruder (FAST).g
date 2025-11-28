;Purge Pellet Extruder.g

; No Purging if nozzle temp under 200 deg and other heaters are above 100 deg
if heat.heaters[3].current >= 160 && heat.heaters[0].current >= 60 && heat.heaters[1].current >= 100 && heat.heaters[2].current >= 80
    ;M98 P"Pellet Feed ENABLE.g"
    ;M98 P"FansMax.g"
    M302 S60 R60
    M118 P0 S"Purging Pellet Extruder..." L2
    G1 E4000 F1838.621 ; Purge
    G4 P20 ; debounce
    M118 P0 S"Purge Complete!" L2
    ;M98 P"FansDefault.g"
    ;M98 P"Pellet Feed DISABLE.g"
else
    M118 P0 S"Purge Cancelled. Heat up extruder to over 200 degrees before purging!" L1
