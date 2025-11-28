; Start print-specific log in same directory as the print file (DEBUG level)
M929 S0
G4 P200
M929 P{job.file.fileName^"_"^state.time^".log"} S3
M118 P0 S{"[INFO] Print logging started for " ^ job.file.fileName ^ " at " ^ state.time}
