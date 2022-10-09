import processing.serial.*;
Serial myPort;
Boolean isOn = false;
String strSerial = "";

void setup(){// Inicializacion de las variables
  size(680, 460); // Tamaño de la pantalla
  surface.setTitle("Ejecicio 4 - Trabajo práctico N2.");// Titulo de la ventana
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.write("0\n");
  myPort.bufferUntil(36);// Almacene en el buffer hasta el caracter $
  
}

void draw(){  
  fill(128);
  background(255);
  textSize(16);
  text("Presiona cualquier tecla para comenzar a transmitir el dato analógico", 100, 50);
  textSize(50);
  text("Valor del canal analógico", 100, 100);
  text("RECIBIDO: " + strSerial, 100,200); 
}

void serialEvent(Serial p) { 
  strSerial = p.readString().replace("$","");
} 

void keyPressed(){
  isOn = !isOn;
  btn(isOn);
}

void btn(Boolean isOn){
  if(isOn){
    myPort.write("1\n");
  }else{
    myPort.write("0\n");
  }
}
