import processing.serial.*;
import grafica.*;

// Para el plot de datos
int i = 0;
int nPoints = 100;
GPointsArray points = new GPointsArray(nPoints);// Arreglo de datos

// Para Histograma
int[] histograma;
int histContador;
GPointsArray histPoints = new GPointsArray(10);

// Para el serialPort
Serial myPort;
Boolean isOn = false;

void setup(){// Inicializacion de las variables
  size(700,1000);//tamaño de la pantalla
  surface.setTitle("Ejecicio 5 - Trabajo práctico N2.");// Titulo de la ventana
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.write("0\n");//Envio un cero para apagar la adquisición de datos
  myPort.bufferUntil(36);// Almacena en el buffer hasta el caracter $
  // Lineal en funciuon del tiempo
  
}

void draw(){ 
    background(255);// Fondo blanco
    
  histograma = new int[10];
  histContador = 0;
  GPlot gHist = new GPlot(this);
  gHist.setPos(100, 500);
  gHist.setTitleText("HISTOGRAMA");
  gHist.getXAxis().setAxisLabelText("Muestra");
  gHist.getYAxis().setAxisLabelText("Valor Entero");
  gHist.startHistograms(GPlot.VERTICAL);  

  GPlot plot = new GPlot(this);
  plot.setPos(100, 100);
  plot.setTitleText("Valor A0");
  plot.getXAxis().setAxisLabelText("Muestra");
  plot.getYAxis().setAxisLabelText("Valor Entero");
  fill(0);// Color negro para las letras
  textSize(16);// tamaño del texto
  text("Presiona cualquier tecla para comenzar a transmitir el dato analógico", 100, 50);
  // Agrego los puntos, en este caso no hay puntos
  plot.setPoints(points);  
  // Dibujo!
  plot.defaultDraw();
  gHist.drawHistograms();
}

void serialEvent(Serial p) {
  int data = int(p.readString().replace("$",""));// Lo que recibo del serialPort elimino el $ y lo paso a int
  println(data);
  i++;
  GPlot plot = new GPlot(this);
  plot.setPos(100, 100);
  if( i < nPoints ){    
    points.add(i, data);// Agrego punto
  }else{
    i++;
    points.add(i, data);// agrego punto
    points.remove(0);// elimino el primer dato para que no se muestre 
  }
  // Add the points
  plot.setPoints(points);  
  // Draw it!
  plot.defaultDraw();
  
  //histPoints.add();
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
