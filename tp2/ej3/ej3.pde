import processing.serial.*;

Serial miPuerto;

int gris = 150;
int x = 10;
Boolean isOn;
String s = " Presione cualquier tecla para encender o apagar el LED.";
String ledOn = "¡Led encendido!";
String ledOff = "¡Led apagado!";
String led = ledOff;

void setup(){  
  surface.setTitle("Ejercicio 3 - Trabajo Práctico 2");
  size(640, 480);
  /* Conectar con el puerto serial */
  String portName = Serial.list()[1];
  miPuerto = new Serial(this, portName, 9600);
  
  print(miPuerto.read() );
  if(miPuerto.read()==0)
    isOn = true;
  if(miPuerto.read()!=0)
    isOn = false;
  //else
  //  isOn = false;
    
}

void draw(){
  background(gris);
  fill(50);  
  textSize(24);
  text(s, 10,10,620,50);  
  textSize(80);
  text(led, 0,0,640,480);
  textAlign(CENTER, CENTER);
}

void keyPressed(){
  isOn = !isOn;
  btn(isOn);
}

void btn(Boolean state){
  if(state == true){
    gris = 250;
    led = ledOn;
    miPuerto.write("1\n");
  }else{
    gris = 150;
    led = ledOff;
    miPuerto.write("0\n");
  }
}
