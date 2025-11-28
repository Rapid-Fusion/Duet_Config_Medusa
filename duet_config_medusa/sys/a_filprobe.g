; ===== /sys/homea.g =====
; Home A to MAX using sensorless homing in stealthChop with reduced current.
; Uses temporary probing speeds, then restores normal limits.

; -------------------------
; Prep
; -------------------------
M400                         ; finish any current moves
G91                          ; relative positioning

; -------------------------
; Driver/mapping (as per your config)
; -------------------------
; A = driver 6.2 (LEFT), B = driver 6.5 (RIGHT)
M569 P6.2 S0 D2 T3:3:5:0     ; A axis driver in stealthChop
M569 P6.5 S0 D2 T3:3:5:0     ; B axis driver (unchanged, listed for completeness)
M584 A6.2 B6.5               ; mapping
M350 A16 B16 I1              ; microstepping
M92 A1259.8425 B1259.8425    ; steps/mm
M208 A0:10 B0:10             ; axis limits

; -------------------------
; Sensorless setup (tune S/H to your mechanics)
; -------------------------
; StallGuard sensitivity: S (-64..63), filter F, H=min steps/s, R0=report only
M915 A S3 F-20 H500 R0         ; adjust S/H for reliable trigger
M574 A2 S3                   ; A homes to MAX using stall detection (S3)

; -------------------------
; Temporary probing speeds (requested)
; -------------------------
M566 A20 B20                 ; jerk (mm/min)
M203 A500 B500               ; max speed (mm/min)
M201 A50 B50                 ; accel (mm/s^2)

; -------------------------
; Lower current for gentle sensorless contact
; -------------------------
M913 A50                     ; 35% of normal current during homing
G4 P100                      ; brief settle

; -------------------------
; Homing sequence (to MAX)
; -------------------------
G1 H1 A15 F1000               ; move toward MAX up to 15 mm @100 mm/min until stall
G4 P200                      ; settle
G1 A-1 F100                  ; back off 1 mm
G1 H1 A3 F400                 ; slower re-approach @40 mm/min

; Set home position at MAX
G92 A10
G1 A-1 F200                  ; move off switch slightly

; -------------------------
; Restore normal current and limits
; -------------------------
M913 A100                    ; back to 100% of normal current

M566 A300 B300               ; normal jerk
M203 A3000 B3000             ; normal max speed
M201 A150 B150               ; normal accel

G90                          ; absolute positioning
M400
M117 "A homed to MAX (sensorless, stealthChop)"
; ===== end /sys/homea.g =====


; SuperPINDA probe on LEFT extruder

;G29 S2 ; clear mesh compensation
;M290 R0 S0 ; reset babystepping

;G53 G1 X0 Y0 F7200 ; move to middle 
;G1 Z100 F7200 ; move Z close to bed
;G1 Z{sensors.probes[2].diveHeights[0]} F1800 ; move z to probe dive height (10mm)

;var initial_z_offset = tools[2].offsets[2]

;M118 P0 S{"Initial tool Z-offset: "^var.initial_z_offset^"mm"} L2

;G30 K2 S-2                                  ; probes and adjusts the tool Z offset to make the actual stop height match the configured value. A tool must be selected first when using G30 S-2.

;M400
;G4 P20

;var new_z_offset = tools[2].offsets[2]
;M118 P0 S{"New tool Z-offset: "^var.new_z_offset^"mm"} L2

;var diff = var.initial_z_offset - var.new_z_offset
;if var.diff > 0
;    M118 P0 S{"Tool Head moved DOWN by "^var.diff^"mm"} L2
;elif var.diff < 0
;    M118 P0 S{"Tool Head moved UP by "^-var.diff^"mm"} L2
;else
;    M118 P0 S{"Tool Head has not moved"} L2

;G1 Z{sensors.probes[2].diveHeights[0]} F720 ; move z back up to probe dive height (10mm)