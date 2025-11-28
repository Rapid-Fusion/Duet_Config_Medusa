; Take Bead Snapshot

M42 P23 S1 ; ON - Signal for Camera to Take Bead Snapshot
G4 S1 ; wait 1 sec
M42 P23 S0 ; OFF - Signal for Camera to Take Bead Snapshot
M118 P0 S"Bead Snapshot Taken!" L2