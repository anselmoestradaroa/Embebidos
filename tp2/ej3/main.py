from machine import Pin
import sys
import utime

led = Pin(25, Pin.OUT)
led.value(0)
estadoLed = 0
comandoPC = ""
isOn = False
while True:
    comandoPC = str(sys.stdin.readline())
    utime.sleep(0.5)
    if comandoPC == "1\n":
        isOn = True
        estadoLed = 1
    if comandoPC == "0\n":
        isOn = False
        estadoLed = 0
    led.value(isOn)
    sys.stdout.write(bytes(estadoLed))
    comandoPC = ""