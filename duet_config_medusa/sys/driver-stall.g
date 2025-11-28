; driver-stall.g

M400
echo "Driver Stall: "^{param.B}^"."^{param.D}^""

if ({param.B}+{param.D}/10 == 2.0) ; U axis
	M42 P3 S1 ; trigger U endstop
	G92 U0
	M118 P0 S"U axis Homed!" L3
	M99

if ({param.B}+{param.D}/10 == 2.1) ; V axis
	M42 P4 S1 ; trigger U endstop
	G92 V0
	M118 P0 S"V axis Homed!" L3
	M99

if ({param.B}+{param.D}/10 == 2.2) ; W axis
	M42 P5 S1 ; trigger U endstop
	G92 W0
	M118 P0 S"W axis Homed!" L3
	M99