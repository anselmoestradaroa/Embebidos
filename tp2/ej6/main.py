from machine import ADC, Pin, Timer, RTC
import sys

# CallBack Function (TIMER)
def writeFile(timer):# El archivo tiene que estar abierto anteriormente
    now = rtc.datetime()
    file.write(str(now[0])  + "," + str(now[1])  + "," + str(now[2])  + "," + str(now[4])  + "," + str(now[5])  + "," + str(now[6])  + "," + str(ADC(26).read_u16()) + "," + str(ADC(27).read_u16()) + ", "  + str(ADC(28).read_u16()) + "\n")
    file.flush()
    print(f"{now[0]:04d}" + "/" + f"{now[1]:02d}" + "/" + f"{now[2]:02d}" + "  " + f"{now[4]:02d}" + ":" + f"{now[5]:02d}" +  ":" + f"{now[6]:02d}" + "  " + str(ADC(26).read_u16()) + "   " + str(ADC(27).read_u16()) + "  "  + str(ADC(28).read_u16()) )

''' const String '''
HELP        = "Para comenzar con la adquisición de datos escriba ON , para finalizar escriba OFF \n"
DATON       = "El adquisidor de datos está encendido y funcionando. Escriba OFF para apagar la adquisición de datos \n"
DATOFF      = "El adquisidor de datos se apagó \n"
UNKNOWN_CMD = "ERROR: Comando no reconocido \n"

''' ADC setup '''
A0 = ADC(26)
A1 = ADC(27)
A2 = ADC(28)

''' LED setup'''
led = Pin(25, Pin.OUT)
led.value(0)

''' DATE setup'''
rtc = RTC() # Real Time Clock, Reloj tiempo real de la Rpi 

''' TIMER setup'''
timer = Timer()

isOn = False
sys.stdout.write(HELP)
while True:    
    comando = str( sys.stdin.readline() ).lower()
    if comando == "on\n" and not isOn:# Si escribes ON y no esta funcionando
        tMuestreo = float( input("Ingresa el tiempo de muestreo en Segundos \n") )
        sys.stdout.write(DATON)
        isOn = True
        ''' File setup'''
        now = rtc.datetime()
        nomFile =  f"{now[0]:04d}" + "-" + f"{now[1]:02d}" + "-" + f"{now[2]:02d}" + " " + f"{now[4]:02d}" + "-" + f"{now[5]:02d}" +  "-" + f"{now[6]:02d}" + ".csv"
        print("Almacenando datos en el archivo...")
        print(nomFile)
        file = open(nomFile, "w")
        file.write("Año" + "," + "Mes" + "," + "Dia" + "," + "Hora" + "," + "Minuto" + "," + "Segundo" + "," + "A0" + "," + "A1" + "," + "A2" + "\n")
        print("AAAA" + "/" + "MM" + "/" + "DD" + "  " + "HH" + ":" + "MM" + ":" + "SS" + "   " + " A0  " + "   " + " A1  " + "  " + " A2  ")
        file.flush()
        timer.init(period = int(tMuestreo*1000), mode=Timer.PERIODIC, callback = writeFile )        
        
    if comando == "off\n" and isOn:# Si escribes OFF y esta funcionando
        sys.stdout.write(DATOFF)
        sys.stdout.write(HELP)
        isOn = False
        timer.deinit()
        file.close()
        print(nomFile + "  ----> ¡Archivo guardado!")
        
    if comando != "on\n" and comando != "off\n" and comando !="\n":# Si no se que escribiste
        sys.stdout.write(UNKNOWN_CMD)
        sys.stdout.write(HELP)
        
    led.value(isOn)# Esta encendido cuando la adquisicion de datos está activa