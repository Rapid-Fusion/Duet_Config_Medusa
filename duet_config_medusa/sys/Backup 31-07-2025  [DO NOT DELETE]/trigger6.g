set global.doorButtonPressed = true

if state.gpOut[19].pwm == 0 ; DOOR is Closed
    M98 P"LED_UserWarningDOOR.g"
    M42 P19 S1 ; OPEN Door
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
else
    M98 P"LED_UserWarningDOOR.g"
    M42 P19 S0 ; CLOSE Door
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"
    M98 P"LED_UserWarningDOOR.g"

    ; Reset LEDs -----------
    ; Machine LED -- WHITE
    M42 P7 S1 ; R
    M42 P8 S1 ; G
    M42 P9 S1 ; B
    ; Door Button LED -- GREEN
    M42 P14 S0 ; R
    M42 P15 S1 ; G
    M42 P16 S0 ; B

set global.doorButtonPressed = false