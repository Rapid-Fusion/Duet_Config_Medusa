; BedSurfaceSelect.g

; if New Bed Type (S) NOT given
if !exists(param.S)
    M118 P0 S"Try Again with a valid Bed Surface Type: e.g. S'ALU' S'CF'" L1
    M99

; if New Bed Type (S) is different from Current Bed Type
if param.S != global.bedSurfaceCurrent
    ; ONLY Select Bed if ALL Bed axes are above 30 mm
    if (move.axes[3].machinePosition > 30 && move.axes[4].machinePosition > 30 && move.axes[5].machinePosition > 30 && move.axes[6].machinePosition > 30)
        ; MOVE BED
        if global.bedSurfaceNew == "ALU"
            ; MOVE to ALU position
        elif global.bedSurfaceNew == "CF"
            ; MOVE to CF position
            
        set global.bedSurfaceCurrent = param.S
    else
        M118 P0 S"Bed NOT in Position. New Bed Type NOT Selected. Current Bed Type is "^global.bedSurfaceCurrent^"." L1
else
    M118 P0 S"Current Bed Type is already set to "^global.bedSurfaceCurrent^"." L2