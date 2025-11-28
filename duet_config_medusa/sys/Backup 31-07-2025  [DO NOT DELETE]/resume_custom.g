G28 ; home

M564 S0 ; allow movement past axis limits
G90 ; absolute position
G1 Z{move.axes[2].babystep+job.layer+1} F3600 ; move to 1mm above current layer
G92 Z{job.layer+1} ; set Z to 1mm above current layer
M564 S1 ; forbid movement past axis limits
