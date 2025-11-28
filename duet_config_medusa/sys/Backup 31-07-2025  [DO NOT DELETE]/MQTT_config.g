; Network and MQTT configuration
M552 S1                                                                           ; Enable network

; MQTT setup for AWS IoT Core
M587 P"a21gla3h05wq25-ats.iot.eu-west-2.amazonaws.com"                            ; Set AWS IoT broker address
M587 X1 U"936eee2bac8ae94bfce5ac650ddcbf041042d855169c4506ec6e3e8ec9ed84d2-certificate.pem.crt" P"936eee2bac8ae94bfce5ac650ddcbf041042d855169c4506ec6e3e8ec9ed84d2-private.pem.key" E"AmazonRootCA1.pem" ; Set paths to certificates

M586 P4 S1                                                                        ; Enable MQTT client