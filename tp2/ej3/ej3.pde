import processing.serial.*;

String txtHelp = "Presiona cualquier tecla para encender o apagar el LED";
String LEDon = "LED ENCENDIDO!\nʘ ‿ ʘ";
String LEDoff = "led apagado\nʘ_ʘ";
Label help = new Label(0, 0, 640, 480/4, txtHelp, 128, 30);
String LEDisOn = LEDoff; 
Label stateLED = new Label(0, 480/4, 640, 480/3, LEDisOn, 128, 30);
boolean isOn = false;
Serial miPuerto;

void setup(){
  surface.setTitle("Ejercicio 3 - Trabajo Práctico 2");
  size(640, 480);  
  miPuerto  = new Serial(this, "COM3", 9600);
  toggleScreen(isOn);  
  ledToggle(isOn);
  help.display();
  stateLED.display();
}

void draw(){
}

void keyPressed(){
  isOn = !isOn;  
  toggleScreen(isOn);
  ledToggle(isOn);
  printIsOn(isOn);
  help.display();
  if(isOn)
    stateLED.setTextLabel(LEDon);
  else
    stateLED.setTextLabel(LEDoff);
  stateLED.display();
}

void toggleScreen(boolean isOn){
  if(isOn){
    background(255);
  }else{
    background(0);
  }
}

void ledToggle(boolean isOn){
  if(isOn){
    miPuerto.write("1\n");
  }else{
    miPuerto.write("0\n");
  }
}

void printIsOn(boolean isOn){
  if(isOn){
    println("Esta encendido");
  }else{
    println("No está encendido");
  }
}
