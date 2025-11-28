; variablepartcooling.g

var pwm = ({param.B}/1275+0.31) ; linear tranformation of PWM range 0-255 to 0.31-0.51

if var.pwm == 0
    M106 P{param.A} S0
else
    if param.A == 0
        M106 P0 S{var.pwm*global.partcoolingfactorLEFT}
    else
        M106 P1 S{var.pwm*global.partcoolingfactorRIGHT}
