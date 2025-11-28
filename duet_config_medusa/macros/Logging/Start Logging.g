; Start general logging with timestamped log file (DEBUG level)
M929 S0
G4 P200
M929 P{"0:/gcodes/Logging/general_log_"^state.time^".log"} S3
M118 P0 S{"[INFO] General logging started at " ^ state.time}
