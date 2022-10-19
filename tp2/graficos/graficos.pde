import processing.serial.*;
import grafica.*;

int data;
// Para el histograma

GPoint[] valoresHistograma;
GPointsArray datosHistograma = new GPointsArray(10);// en la pantalla muestro DECILES
GPoint decilActual;// Obtengo el punto
GPlot histograma;

// Para el SerialPort
Serial miPuerto;

// Banderas de control
Boolean isOn = false; // isOn = true si la adquisición de datos está activada

void setup() {
  // Configuracion de la ventana
  size(700, 1000);//Tamaño de la ventana
  surface.setTitle("Ejecicio 5 - Trabajo práctico N2.");// Título de la ventana
  background(255);

  // Configuración del puerto serial
  miPuerto = new Serial(this, Serial.list()[1], 9600);
  miPuerto.write("0\n");//Envio un cero para desactivar la adquisición de datos, si es que está activada
  miPuerto.bufferUntil(36);// Almacena en el buffer hasta que encuentra el caracter $

  // Configuracion del label en pantalla
  fill(0);// Color negro para las letras
  textSize(16);// tamaño del texto
  text("Presiona cualquier tecla para comenzar a transmitir el dato analógico", 100, 50);

  // Para el histograma
  println("Cantidad de valores de datosHistograma " + datosHistograma.getNPoints() );
  for(int i = 0 ; i < 10; i++){
    datosHistograma.add(i, i*10);
  }
  println("Cantidad de valores de datosHistograma " + datosHistograma.getNPoints() );
    histograma.setPoints(datosHistograma);
}

void draw() {

  histograma.setPoints(datosHistograma);
  // Configuracion del histograma
  
  
  histograma.startHistograms(GPlot.VERTICAL);
  histograma.setPos(100,500);
  histograma.setTitleText("Histograma");
  histograma.getXAxis().setAxisLabelText("Decil");
  histograma.getYAxis().setAxisLabelText("Cant Datos");
  histograma.setPoints(datosHistograma);
  
  histograma.beginDraw();
  histograma.drawBackground();
  histograma.drawBox();
  histograma.drawYAxis();
  histograma.drawTitle();
  histograma.drawHistograms();
  histograma.endDraw();


	//println("Vector datosHistograma");
	//imprimirGArray(datosHistograma);

	//println("Vector arregloPrueba");
	//imprimirGArray(arregloPrueba);
	//println("El valor de data dentro del draw es " + data);
}

void serialEvent(Serial p) {
//data++;
println("El valor de data dentro del serialEvent es " + data);
  try{
 	 data = int(p.readString().replace("$", ""));// Lo que recibo del serialPort elimino el $ y lo paso a int
 	 //println("El valor de data dentro del evento serial es " + data);
  }catch(NullPointerException e){
    println("Error al recuperar el dato");
    data = -1;
  }

    for(int i = 0 ; i < datosHistograma.getNPoints(); i++){
    datosHistograma.add(i, i*10);
  }
}

void keyPressed() {// Cuando se presiona una tecla
  isOn = !isOn;// toogle isOn
  receiveData(isOn);// Envio el valor de isOn en formato int.
}

void receiveData(Boolean isOn) {
  if (isOn) {
    miPuerto.write("1\n");
  } else {
    miPuerto.write("0\n");
  }
}

void imprimirGArray(GPointsArray arregloDeDatos){
	for(int i = 0; i < arregloDeDatos.getNPoints(); i++){
		GPoint punto = arregloDeDatos.get(i);
		println("( " + punto.getX() + " , " + punto.getY() + ")" );
	}
	//arregloDeDatos;

}

void initGArray(GPoint[] vectorDeDatos){
  println(vectorDeDatos.length);
  		vectorDeDatos[0].setXY(1,2);
	for(int i = 0; i < vectorDeDatos.length-1; i++){
		vectorDeDatos[0].setXY(1,2);
	}
}
