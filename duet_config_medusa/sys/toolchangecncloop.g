; toolchangecncloop.g

M291 R"WARNING" P"Make sure all tools are DOCKED before running this test!" K{"OK","Cancel"} S4
if (input == 0) ; OK selected
    var count = 0
    while var.count < 10
        M98 P"toolpickupcnc.g"
        M98 P"tooldockcnc.g"
        set var.count = var.count + 1
