; a_bedrestoreheight.g

G92 U0 V0 W0 C0

G1 U34 V34 F50 ; move back up
M400
G4 P20
G1 W34 C34 F50 ; move front up
M400
G4 P20
G1 U{global.U_coor} V{global.V_coor} F50 ; adjust back to print height
M400
G4 P20
G1 W{global.W_coor} C{global.C_coor} F50 ; adjust front to print height
M400
G4 P20