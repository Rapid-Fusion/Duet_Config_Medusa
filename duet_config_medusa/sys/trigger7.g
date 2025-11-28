;trigger7.g

M118 P0 S"Siemens PLC Motion Fault!" L1

if exists(job.build)
    M25
    M118 P0 S"Clear Motion fault before resuming print!" L1
else
    M118 P0 S"Clear Motion fault before starting print!" L1

M18 ; disable