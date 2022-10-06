'''
Trabajo práctico 1
Alumno: Anselmo Estrada Roa
Materia: Programación de dispositivos móviles y embebidos
2do Cuatrimestre 2022

Desarrollar un programa para que encienda y apague el
Led auto contenido en la placa de cada 1 segundo, pero
sin usar la función delay(), usar en cambio el una
interrupción con el reloj interno.
'''
from machine import Pin, Timer
# Declaro la variable led de tipo Pin
# El led en la board es el 25 y lo declaro como salida
led = Pin(25, Pin.OUT) 
led.value(1)# Seteo el valor del en alto

timer01 = Timer()# Declaro variable timer01 del tipo Timer
# Inicializo timer
# Periodo = 1000ms
# mode = Timer periódico
# Callback = Toggle la la salida
timer01.init(period=1000, mode=Timer.PERIODIC, callback=lambda t:led.value(not led.value()) )
