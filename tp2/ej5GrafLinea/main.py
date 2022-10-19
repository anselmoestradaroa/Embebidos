from machine import Pin, ADC, Timer
import sys

ADC26 = ADC(26)
led = Pin(25, Pin.OUT)
isOn = False
led.value(isOn)
timer = Timer()
comandoPC = ""

while True:
    comandoPC = sys.stdin.readline()
    if comandoPC == "1\n" and not isOn:
        isOn = True
        timer.init(period = 1000, mode=Timer.PERIODIC, callback = lambda t:sys.stdout.write(  "$" + str( ADC26.read_u16()) ) )
    if comandoPC == "0\n" and isOn:
        isOn = False
        timer.deinit()
    led.value(isOn)
    comandoPC = ""