if sensors.gpIn[21].value == 0 ; VFD Fault
    M118 P0 S"VFD Fault. Job Cancelled... Check VFD errors." L1
    M0 ; unconditional stop
