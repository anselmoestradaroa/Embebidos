import processing.serial.*; // Para la comunicacion serial
import controlP5.*;         // Para la GUI
import grafica.*;           // Para los Graficos, Ya habia creado los graficos con esta librería, se que se pueden hacer graficos con ControlP5
Serial myPort;							// Inicialización del puerto Serial

String fileNameFromSave=""; 
int status=0;

// PARA EL HISTOGRAMA
int[] pilaDatos = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; // 10 Datos para el histograma
GPlot miHistograma;// Objeto donde se dibuja el histograma
GPointsArray pHistograma = new GPointsArray(pilaDatos.length); // Objeto con los puntos del histograma
int cantDatos = 0;
// PARA EL GRAFICO DE LINEA
int i = 0;
int nPoints = 100;// Cantidad maxima de datos
GPointsArray vacio = new GPointsArray(nPoints);
GPointsArray ad0GrafLinea = new GPointsArray(nPoints);// Objeto con los puntos del grafico de linea
GPointsArray ad1GrafLinea = new GPointsArray(nPoints);// Objeto con los puntos del grafico de linea
GPointsArray ad2GrafLinea = new GPointsArray(nPoints);// Objeto con los puntos del grafico de linea
GPlot grafLinea;
// Para configurar el tiempo de muestreo
int tiempo ;
Textfield tf_muestreo;

ControlP5 cp5;// Creo objeto ControlP5 donde se insertan las componentes de la GUI

// Color
color negro  =  color(0  , 0  , 0  );
color blanco =  color(255, 255, 255);
color rojo   =  color(255, 0  , 0  );
color verde  =  color(0  , 255, 0  );
color azul   =  color(0  , 0  , 255);

// Toogle boton pausa
boolean toggle = false;

void setup() {
  size(800, 600);
  background( blanco );
  cp5 = new ControlP5(this);
  
  ControlFont fontH1 = new ControlFont( createFont("Arial", 20, true) , 25);// Creo una fuente para usar en el sketch
  ControlFont fontH2 = new ControlFont( createFont("Arial", 20, true) , 20);
  ControlFont fontH3 = new ControlFont( createFont("Arial", 20, true) , 16);
  ControlFont fontH4 = new ControlFont( createFont("Arial", 20, true) , 12);
  ControlFont fontH5 = new ControlFont( createFont("Arial", 20, true) , 10);

  cp5.addLabel("lbl_Fecha")                                   // Nombre del objeto lbl ---> label
    .setValue("Acá debe ir la fecha actual de la compu")      // String del Label
    .setSize(100, 30)                                         // Tamaño del label
    .setPosition(400, 400)                                    // Posición en la ventana
    .setFont(fontH2)                                          // Tamaño de fuente del texto
    .setColor( negro )
  ;

  cp5.addLabel("lbl_Muestreo")          // Nombre del objeto lbl ---> label
    .setValue("Tiempo de Muestreo")     // String del Label
    .setSize(100, 30)                   // Tamaño del label
    .setPosition(400, 30)               // Posición en la ventana
    .setFont(fontH1)                    // Tamaño de fuente del texto
    .setColor( negro )
  ;

  cp5.addLabel("lbl_seg")   // Nombre del objeto lbl ---> label
    .setValue(" segundos")  // String del Label
    .setSize(100, 30)       // Tamaño del label
    .setPosition(670, 30)   // Posición en la ventana
    .setFont(fontH1)        // Tamaño de fuente del texto
    .setColor( negro )
  ;

  tf_muestreo = cp5.addTextfield("tf_TiempoMuestreo") // Nombre del objeto tf ---> textfield
    .setValue("1")                     // Valor predeterminado
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

  cp5.addButton("btn_Pausar")
    .setSize(100, 70)
    .setPosition(500, 100)
    .setFont(fontH4)            // Tamaño de la fuente del texto del boton
    .setLabel("Pausar")
  ;

  // Inicializo histograma
	miHistograma = new GPlot(this);
	miHistograma.setPos(0, 0);
	miHistograma.setDim(300, 200);
	//miHistograma.setYLim(-0.02, 0.45);
	//miHistograma.setXLim(-5, 5);
	miHistograma.getTitle().setText("Histograma con (" + str(cantDatos) + " muestras)");
	miHistograma.getTitle().setTextAlignment(LEFT);
	miHistograma.getTitle().setRelativePos(0);
	miHistograma.getYAxis().getAxisLabel().setText("Cantidad de Muestras");
	miHistograma.getYAxis().getAxisLabel().setTextAlignment(RIGHT);
	miHistograma.getYAxis().getAxisLabel().setRelativePos(1);

	miHistograma.startHistograms(GPlot.VERTICAL);
	miHistograma.getHistogram().setDrawLabels(true);
	miHistograma.getHistogram().setRotateLabels(true);
	miHistograma.getHistogram().setBgColors(new color[] {
	color(0, 0, 255, 50), color(0, 0, 255, 100), 
	color(0, 0, 255, 150), color(0, 0, 255, 200)
	}
	);

	// Inicializo grafico de lineas
	grafLinea = new GPlot(this);
  grafLinea.setPos(0, 300);
  grafLinea.setDim(300, 200);
  grafLinea.setTitleText("Valor de las entrada analógicas");
  grafLinea.getXAxis().setAxisLabelText("Muestra");
  grafLinea.getYAxis().setAxisLabelText("Valor Entero");

  // Para AD0
  grafLinea.addLayer("AD0", ad0GrafLinea);// agrego Layer
  grafLinea.getLayer("AD0").setLineColor( rojo );  // Color de la linea
  grafLinea.getLayer("AD0").setPointColor( rojo ); // Color del punto

  // Para AD1
  grafLinea.addLayer("AD1", ad1GrafLinea);// Agrego Layer
	grafLinea.getLayer("AD1").setLineColor( azul ) ;// Agrego color de la linea
	grafLinea.getLayer("AD1").setPointColor( azul ); // Agrego color del punto

	// Para AD2
  grafLinea.addLayer("AD2", ad2GrafLinea);// Agrego Layer
  grafLinea.getLayer("AD2").setLineColor(  verde );
  grafLinea.getLayer("AD2").setPointColor(  verde);
  // Inicializo Serial Port
	myPort = new Serial(this, Serial.list()[1], 9600);
	myPort.write("0\n\r");// escribo un cero para que no empiece a enviar datos desde la RPIO
	myPort.bufferUntil(10);// Almacene en el buffer hasta el caracter lf
// FIN setup desde el histograma


}

void draw(){
  background( blanco );
  // Dibujo!  
  grafLinea.setPoints(ad2GrafLinea);// Primer Layer, si no está no funciona NTIXQ

	grafLinea.getLayer("AD0").setPoints(ad0GrafLinea);
	grafLinea.getLayer("AD1").setPoints(ad1GrafLinea);
	grafLinea.getLayer("AD2").setPoints(ad2GrafLinea);

  // Draw the plot  
  grafLinea.beginDraw();


  grafLinea.drawBox();
  grafLinea.drawXAxis();
  grafLinea.drawYAxis();
  grafLinea.drawTitle();


  grafLinea.drawLines();
  grafLinea.drawPoints();


	grafLinea.drawLegend(new String[] {"", "AD0", "AD1", "AD2"}, new float[] {-1, 0.1, 0.3, 0.5}, 
                  new float[] {-1, 0.95, 0.95, 0.95});
  grafLinea.drawLabels();


  grafLinea.endDraw();

	miHistograma.setPoints(pHistograma);
	miHistograma.getTitle().setText("Histograma con (" + str(cantDatos) + " muestras)");
	miHistograma.beginDraw();
	miHistograma.drawBackground();
	miHistograma.drawBox();
	miHistograma.drawYAxis();
	miHistograma.drawTitle();
	miHistograma.drawHistograms();
	miHistograma.endDraw();
}

void serialEvent(Serial p) {
	String strSerial = p.readString();                 // Lectura del String del SerialPort
	int[] ad = int( split(strSerial, "," ) );          // Arreglo con los datos numericos de los 3 ADC
	println( ad[0] + " " + ad[1] + " " + ad[2] + " "); // Imprime los valores por consola
	cantDatos++;                                       // Sumo uno a la cantidad de datos recibido
	int indiceAD0 = (9 * ad[0])/65535;                 // Calculo el decil en que se encuentra el dato
	pilaDatos[ indiceAD0 ]++;                          // aumento en uno la cantidad del decil
	imprimirArreglo(pilaDatos);                        // Imprimo el arreglo histograma por consola

	pHistograma = new GPointsArray(pilaDatos.length);
	for(int i = 0; i < pilaDatos.length; i++)
		pHistograma.add(i, pilaDatos[i], "Decil " + i);

  if( cantDatos < nPoints ){    
    ad0GrafLinea.add(cantDatos, ad[0]);// Agrego punto
    ad1GrafLinea.add(cantDatos, ad[1]);// Agrego punto
    ad2GrafLinea.add(cantDatos, ad[2]);// Agrego punto
  }else{
    ad0GrafLinea.add(cantDatos, ad[0]);// agrego punto
    ad0GrafLinea.remove(0);// elimino el primer dato para que no se muestre 

    ad1GrafLinea.add(cantDatos, ad[1]);// agrego punto
    ad1GrafLinea.remove(0);// elimino el primer dato para que no se muestre 

    ad2GrafLinea.add(cantDatos, ad[2]);// agrego punto
    ad2GrafLinea.remove(0);// elimino el primer dato para que no se muestre 
  }
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


	background( blanco );
	cantDatos = 0;
	// Limpio el Histograma
	for(int i = 0; i < pilaDatos.length; i++)
		pilaDatos[i] = 0;
	pHistograma = new GPointsArray(pilaDatos.length);
	for(int i = 0; i < pilaDatos.length; i++)
		pHistograma.add(i, pilaDatos[i], "Decil " + i);

	// Limpio el grafico de lineas


	while(ad0GrafLinea.getNPoints() != 0){
		ad0GrafLinea.remove(0);
		ad1GrafLinea.remove(0);
		ad2GrafLinea.remove(0);
	}
}

void btn_Finalizar(){
	myPort.write("0\n\r");

}

void btn_Pausar(){
	toggle = !toggle;

	if(toggle){
		myPort.write("0\n\r");
	}
	else{
		tiempo = int( tf_muestreo.getText() );
		myPort.write("1" + tiempo + "\n\r");
	}
}

void btn_Guardar(){
  selectOutput("Elije el nombre del archivo...", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    status=1;
  } else {
    println("User saves as " + selection.getAbsolutePath());

    String[] saveFile = new String[10];// Almaceno el histograma
    saveFile[0] = str(pilaDatos[0]);
    saveFile[1] = str(pilaDatos[1]);
    saveFile[2] = str(pilaDatos[2]);
    saveFile[3] = str(pilaDatos[3]);
    saveFile[4] = str(pilaDatos[4]);
    saveFile[5] = str(pilaDatos[5]);
    saveFile[6] = str(pilaDatos[6]);
    saveFile[7] = str(pilaDatos[7]);
    saveFile[8] = str(pilaDatos[8]);
    saveFile[9] = str(pilaDatos[9]);
    saveStrings(selection.getAbsolutePath(), saveFile);
    status=2; 
    fileNameFromSave = selection.getAbsolutePath();
  }//else
}//func 
