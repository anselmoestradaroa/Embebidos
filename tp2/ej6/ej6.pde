import processing.serial.*;

import controlP5.*;
// INICIO desde el histograma
import grafica.*;
Serial myPort;
int[] pilaDatos = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
GPlot plot3;// Grafico
GPointsArray puntos = new GPointsArray(pilaDatos.length);
int cantDatos = 0;
// FIN desde el histograma
int tiempo = 30;
Textfield tf_muestreo;

ControlP5 cp5;// Creo objeto ControlP5 donde se insertan las componentes de la GUI

void setup() {
  size(800, 600);
  background(128);
  cp5 = new ControlP5(this);
  
  ControlFont fontH1 = new ControlFont( createFont("Arial", 20, true) , 25);// Creo una fuente para usar en el sketch
  ControlFont fontH2 = new ControlFont( createFont("Arial", 20, true) , 20);
  ControlFont fontH3 = new ControlFont( createFont("Arial", 20, true) , 16);
  ControlFont fontH4 = new ControlFont( createFont("Arial", 20, true) , 12);
  ControlFont fontH5 = new ControlFont( createFont("Arial", 20, true) , 10);

  cp5.addLabel("lbl_Muestreo")          // Nombre del objeto lbl ---> label
    .setValue("Tiempo de Muestreo")     // String del Label
    .setSize(100, 30)                   // Tamaño del label
    .setPosition(400, 30)               // Posición en la ventana
    .setFont(fontH1)                    // Tamaño de fuente del texto
  ;

  cp5.addLabel("lbl_seg")   // Nombre del objeto lbl ---> label
    .setValue(" segundos")  // String del Label
    .setSize(100, 30)       // Tamaño del label
    .setPosition(670, 30)   // Posición en la ventana
    .setFont(fontH1)        // Tamaño de fuente del texto
  ;

  tf_muestreo = cp5.addTextfield("tf_TiempoMuestreo") // Nombre del objeto tf ---> textfield
    .setValue("30")                     // Valor predeterminado
    .setSize(35, 30)                    // Tamaño del cuadro
    .setPosition(640, 30)               // Posición en la ventana
    .setLabel("")                       // Sin etiqueta
    .setInputFilter(ControlP5.INTEGER)  // Filtro, solo enteros
    .setFont(fontH3)                    // Tamaño de fuente del texto
  ;

  cp5.addButton("btn_Comenzar") // Nombre del objeto btn ---> button
    .setSize(100, 70)           // Tamaño del boton
    .setPosition(400, 100)      // Posicion del Boton
    .setFont(fontH4)            // Tamaño de la fuente del texto del boton
    .setLabel("Comenzar")       // Etiqueta del boton
    ;
  
  cp5.addButton("btn_Finalizar")
    .setSize(100, 70)
    .setPosition(400, 200)
    .setFont(fontH4)            // Tamaño de la fuente del texto del boton
    .setLabel("Finalizar")
    ;
  
  cp5.addButton("btn_Guardar")
    .setSize(100, 70)
    .setPosition(400, 300)
    .setFont(fontH4)            // Tamaño de la fuente del texto del boton
    .setLabel("Guardar")
  ;

  // INICIO setup desde el histograma
  // INICIALIZO EL GRAFICO
	plot3 = new GPlot(this);
	plot3.setPos(0, 0);
	plot3.setDim(300, 200);
	//plot3.setYLim(-0.02, 0.45);
	//plot3.setXLim(-5, 5);
	plot3.getTitle().setText("Histograma con (" + str(cantDatos) + " muestras)");
	plot3.getTitle().setTextAlignment(LEFT);
	plot3.getTitle().setRelativePos(0);
	plot3.getYAxis().getAxisLabel().setText("Cantidad de Muestras");
	plot3.getYAxis().getAxisLabel().setTextAlignment(RIGHT);
	plot3.getYAxis().getAxisLabel().setRelativePos(1);
	plot3.setPoints(puntos);
	plot3.startHistograms(GPlot.VERTICAL);
	plot3.getHistogram().setDrawLabels(true);
	plot3.getHistogram().setRotateLabels(true);
	plot3.getHistogram().setBgColors(new color[] {
	color(0, 0, 255, 50), color(0, 0, 255, 100), 
	color(0, 0, 255, 150), color(0, 0, 255, 200)
	}
	);

	myPort = new Serial(this, Serial.list()[1], 9600);
	myPort.write("0\n\r");// escribo un cero para que no empiece a enviar datos desde la RPIO
	myPort.bufferUntil(10);// Almacene en el buffer hasta el caracter lf
// FIN setup desde el histograma


  cp5.addLabel("lbl_Fecha")                                   // Nombre del objeto lbl ---> label
    .setValue("Acá debe ir la fecha actual de la compu")      // String del Label
    .setSize(100, 30)                                         // Tamaño del label
    .setPosition(400, 400)                                     // Posición en la ventana
    .setFont(fontH2)                                          // Tamaño de fuente del texto
  ;
}

void draw(){
  	//background(255);
	plot3.setPoints(puntos);
	plot3.getTitle().setText("Histograma con (" + str(cantDatos) + " muestras)");
	plot3.beginDraw();
	plot3.drawBackground();
	plot3.drawBox();
	plot3.drawYAxis();
	plot3.drawTitle();
	plot3.drawHistograms();
	plot3.endDraw();
}

void serialEvent(Serial p) {
	String strSerial = p.readString();
	int[] ad = int( split(strSerial, "," ) );
	println( ad[0] + " " + ad[1] + " " + ad[2] + " ");


	cantDatos++;
	background(255);
	// int valorMedicion = int( p.readString().replace("$","") );// Paso el valor de la medida a entero
	int indice = (9 * ad[0])/65535;
	// println("El valor de la medida " + cantDatos + " es : " + valorMedicion + " y se encuentra en el decil " + indice);
	pilaDatos[indice]++;
	imprimirArreglo(pilaDatos);
// 
	puntos = new GPointsArray(pilaDatos.length);
	for(int i = 0; i < pilaDatos.length; i++)
	puntos.add(i, pilaDatos[i], "Decil " + i);
}

void imprimirArreglo(int[] a){
	for(int i = 0; i < a.length; i++)
		print(a[i] + " ");
	println();
}

void btn_Comenzar(){
	println("Vamos a comenzar");
	tiempo = int( tf_muestreo.getText() );
	println(tiempo);
  myPort.write("1" + tiempo + "\n\r");
}

void btn_Finalizar(){
	myPort.write("0\n\r");
}
/* Falta implementar los botones y dejar un poco mas lindo el asunto

*/
