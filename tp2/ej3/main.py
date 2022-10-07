from machine import Pin
import sys

comandoPC = ""
isOn = False
led = Pin(25, Pin.OUT)
led.value(isOn)

while True:
    comandoPC = sys.stdin.readline(1)# Leo solo 1 caracter
    #utime.sleep(0.2)
    if comandoPC == "1":
        isOn = True
        estadoLed = 1
    if comandoPC == "0":
        isOn = False
    led.value(isOn)
    comandoPC = ""
