import processing.serial.*;

Serial myPort;
Boolean isOn = false;
String strSerial = "";
int x = 1000;
int y = 450;

void setup(){// Inicializacion de las variables
  size(1000,900);//tamaño de la pantalla
  surface.setTitle("Ejecicio 5 - Trabajo práctico N2.");// Titulo de la ventana
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.write("0\n");//Envio un cero para apagar la adquisición de datos
  myPort.bufferUntil(36);// Almacena en el buffer hasta el caracter $  
  //Grafico(String xl, String yl, String title, int xPos, int yPos, int w, int h)

}

void draw(){ 
    background(255);// Fondo blanco
    Grafico miGrafico = new Grafico("Valor de X", "Valor de Y", "Titulo del grafico", 10, 10, width, height);
  miGrafico.linea(false);
  fill(0);// Color negro para las letras

  textSize(16);// tamaño del texto
  text("Presiona cualquier tecla para comenzar a transmitir el dato analógico", 100, 50);
//size(400, 400);
//noSmooth();
//200*parseInt(strSerial)/20000
  circle(x, y, 5);
  //textSize(50);// tamaño del texto
  //text("Valor del canal analógico", 100, 100);
  //text("RECIBIDO: " + strSerial, 100,200); 
}

void serialEvent(Serial p) {
  x -= 10;
  y = int(parseFloat(strSerial)*0.0061) + 450;
  strSerial = p.readString().replace("$","");
  println( y );
} 

void keyPressed(){// Cuando se presiona una tecla
  isOn = !isOn;// toogle isOn
  receiveData(isOn);// Envio el valor de isOn en formato int.
}

void receiveData(Boolean isOn){
  if(isOn){
    myPort.write("1\n");
  }else{
    myPort.write("0\n");
  }
}
