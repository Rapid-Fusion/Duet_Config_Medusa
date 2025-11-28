; solenoid_test.g

M291 R"WARNING" P"Make sure all tools are DOCKED before running this test!" K{"OK","Cancel"} S4
if (input == 0) ; OK selected
    var count = 0
    while var.count < 10
        M98 P"solenoid_lock.g"
        M98 P"solenoid_unlock.g"
        set var.count = var.count + 1
