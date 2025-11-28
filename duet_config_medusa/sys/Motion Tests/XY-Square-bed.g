; XY-Square-bed.g

M291 R"WARNING" P"Make sure all tools are DOCKED & Scanning z-probe before running this test!" K{"OK","Cancel"} S4
if (input == 0) ; OK selected
    G29 S2
    T-1
    G90
    G1 X0 Y0 Z10 F{global.tool_change_speed}
    G29 S1
    G1 Z5 F720
    M208 X-530:630 Y-560:590 ; set bed limits
    M400
    M98 P"Motion Tests/XY-Square.g"
    G29 S2
    M208 X-650:650 Y-385:690 ; reset print limits
