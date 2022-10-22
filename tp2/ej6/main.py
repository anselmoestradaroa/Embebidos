from machine import ADC, Pin, Timer
import sys
# CallBack Function (TIMER)
def enviarDatos(timer):
    sys.stdout.write(str(ADC(26).read_u16()) + "," + str(ADC(27).read_u16()) + ","  + str(ADC(28).read_u16()) + ","  + "\n")
''' ADC setup '''
A0 = ADC(26)
A1 = ADC(27)
A2 = ADC(28)
''' LED setup'''
led = Pin(25, Pin.OUT)
led.value(0) 
''' TIMER setup'''
timer = Timer()
isOn = False
while True:
    comando = sys.stdin.readline()

    if len( comando ) > 1:# Si se tiene mas de un caracter
        if  bool( int( comando[0] ) ) and not isOn:# Si quieres encender y no está encendido
            isOn = True
            tiempo = int( comando[1:] )      # Tiempo en segundos
            timer.init(period = int(tiempo*1000), mode=Timer.PERIODIC, callback = enviarDatos )
        if not(bool( int( comando[0] ) )) and isOn:# Si escribes OFF y esta funcionando
            isOn = False
            timer.deinit()
    led.value(isOn)# Esta encendido cuando la adquisicion de datos está activa
    comando = ""