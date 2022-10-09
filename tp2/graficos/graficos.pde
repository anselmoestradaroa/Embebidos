import processing.serial.*;
import grafica.*;


public int data;
// Para el grafico con respecto al tiempo
int i = 0; // Numero de la muestra;
int cantDatosPantalla = 100;// Cantidad de puntos maximos mostrados en pantalla
GPointsArray datosTiempo = new GPointsArray(cantDatosPantalla);// Arreglo con la cantidad de datos mostrados en la pantalla
GPlot lineal;

// Para el histograma
GPoint[] valoresHistograma;
GPointsArray datosHistograma = new GPointsArray(10);// en la pantalla muestro DECILES
GPoint decilActual;// Obtengo el punto
GPlot histograma;

// Para el SerialPort
Serial miPuerto;

// Banderas de control
Boolean isOn = false; // isOn = true si la adquisición de datos está activada

void setup(){	
	// Configuracion de la ventana
	size(700,1000);//Tamaño de la ventana
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

  histograma = new GPlot(this);
	valoresHistograma = new GPoint[10];
  decilActual = new GPoint(5,5);
}

void draw(){
  background(255);
  fill(0);// Color negro para las letras
  textSize(16);// tamaño del texto
  text("Presiona cualquier tecla para comenzar a transmitir el dato analógico", 100, 50);
  
  if( miPuerto.read()>0 ){
    
  int valHistograma = int(map(data, 0, 65536, 0, 10));  
  
 // GPoint decilActual = datosHistograma.get( valHistograma );
  float valorAnterior = decilActual.getY();// Obtengo el valor de y del punto
  decilActual.setY(valorAnterior + 1.0);// aumento en 1.0
  datosHistograma.set(valHistograma, decilActual);
  //println(data + " " + valorAnterior + " " + valHistograma + " "+ data);
  //float histogramaValorAnterior = valoresHistograma[valHistograma].getY();
  //valoresHistograma[valHistograma].setY(histogramaValorAnterior+1.0);
  i++;
  GPlot lineal = new GPlot(this);
  lineal.setPos(100, 100);
  if( i < cantDatosPantalla ){    
    datosTiempo.add(i, data);// Agrego punto
  }else{
    //i++;
    datosTiempo.add(i, data);// agrego punto
    datosTiempo.remove(0);// elimino el primer dato para que no se muestre 
  }
  // Add the datosTiempo
  lineal.setPoints(datosTiempo);  
  // Draw it!
  lineal.defaultDraw();
  
  //datosHistograma.add(valoresHistograma);
  histograma.setPoints(datosHistograma);
  

  }
  
  // Configuracion del grafico con respecto al tiempo
  lineal = new GPlot(this);// Inicializa un GPlot en este applet
  lineal.setPos(100,100);// Posición del gráfico
  lineal.setTitleText("Valor A0");// Título del gráfico
  lineal.getXAxis().setAxisLabelText("Muestra");// Set del nombre del eje X
  lineal.getYAxis().setAxisLabelText("Valor del ADC");// Set del nombre del eje Y
  lineal.setPoints(datosTiempo);
  lineal.defaultDraw();

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
}

void serialEvent(Serial p) {
  //data = int(p.readString().replace("$",""));// Lo que recibo del serialPort elimino el $ y lo paso a int
  println(p.readString().replace("$","")+"El valor de data dentro de la serialEvent es " + data);
  
}

void keyPressed(){// Cuando se presiona una tecla
  isOn = !isOn;// toogle isOn
  receiveData(isOn);// Envio el valor de isOn en formato int.
}

void receiveData(Boolean isOn){
  if(isOn){
    miPuerto.write("1\n");
  }else{
    miPuerto.write("0\n");
  }
}
