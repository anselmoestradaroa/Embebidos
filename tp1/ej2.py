'''
Trabajo práctico 1
Alumno: Anselmo Estrada Roa
Materia: Programación de dispositivos móviles y embebidos
2do Cuatrimestre 2022

Desarrollar un programa para que lea el valor analógico
de la entrada A0 y lo escriba por la terminal cada
5 segundos, pero sin usar la función delay(), usar en
cambio el una interrupción con el reloj (Timer) interno.
'''
from machine import ADC, Timer
analogValue = ADC(26)

timer01 = Timer().init(period=5000, mode=Timer.PERIODIC, callback=lambda t:print(analogValue.read_u16()) )