import processing.serial.*; // Para la comunicacion serial
import controlP5.*;         // Para la GUI
import grafica.*;           // Para los Graficos, Ya habia creado los graficos con esta librería, se que se pueden hacer graficos con ControlP5

Serial myPort; // Inicialización del puerto Serial

// PARA EL HISTOGRAMA
int[] pilaDatos = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; // 10 Datos para el histograma
GPlot miHistograma;// Objeto donde se dibuja el histograma
GPointsArray pHistograma = new GPointsArray(pilaDatos.length); // Objeto con los puntos del histograma
int cantDatos = 0;

// PARA EL GRAFICO DE LINEA
int i = 0;
int nPoints = 100;// Cantidad maxima de datos
GPointsArray ad0GrafLinea = new GPointsArray(nPoints);// AObjeto con los puntos del grafico de linea
GPointsArray ad1GrafLinea = new GPointsArray(nPoints);// AObjeto con los puntos del grafico de linea
GPointsArray ad2GrafLinea = new GPointsArray(nPoints);// AObjeto con los puntos del grafico de linea








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

  // INICIO setup desde el histograma
  // INICIALIZO EL GRAFICO
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
	miHistograma.setPoints(pHistograma);
	miHistograma.startHistograms(GPlot.VERTICAL);
	miHistograma.getHistogram().setDrawLabels(true);
	miHistograma.getHistogram().setRotateLabels(true);
	miHistograma.getHistogram().setBgColors(new color[] {
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
    .setPosition(400, 400)                                    // Posición en la ventana
    .setFont(fontH2)                                          // Tamaño de fuente del texto
  ;
}

void draw(){
  GPlot plot = new GPlot(this);
  plot.setPos(0, 300);
  plot.setDim(300, 200);
  plot.setTitleText("Valor A0");
  plot.getXAxis().setAxisLabelText("Muestra");
  plot.getYAxis().setAxisLabelText("Valor Entero");
  // Agrego los puntos, en este caso no hay puntos
  plot.setPoints(ad0GrafLinea);

  plot.addLayer("AD1", ad1GrafLinea);

  plot.addLayer("AD2", ad2GrafLinea);
  


  // Dibujo!
  plot.defaultDraw();
  //plot.beginDraw();
  //plot.endDraw();

  //background(255);
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
	String strSerial = p.readString();
	int[] ad = int( split(strSerial, "," ) );
	println( ad[0] + " " + ad[1] + " " + ad[2] + " ");
	cantDatos++;
	background(255);

	int indice = (9 * ad[0])/65535;

	pilaDatos[indice]++;
	imprimirArreglo(pilaDatos);
// 
	pHistograma = new GPointsArray(pilaDatos.length);
	for(int i = 0; i < pilaDatos.length; i++)
	pHistograma.add(i, pilaDatos[i], "Decil " + i);

GPlot plot = new GPlot(this);
  if( cantDatos < nPoints ){    
    ad0GrafLinea.add(cantDatos, ad[0]);// Agrego punto
    ad1GrafLinea.add(cantDatos, ad[1]);// Agrego punto
    ad2GrafLinea.add(cantDatos, ad[2]);// Agrego punto
  }else{
    cantDatos++;
    ad0GrafLinea.add(cantDatos, ad[0]);// agrego punto
    ad0GrafLinea.remove(0);// elimino el primer dato para que no se muestre 

    ad1GrafLinea.add(cantDatos, ad[1]);// agrego punto
    ad1GrafLinea.remove(0);// elimino el primer dato para que no se muestre 

    ad2GrafLinea.add(cantDatos, ad[2]);// agrego punto
    ad2GrafLinea.remove(0);// elimino el primer dato para que no se muestre 
  }
  // Add the ad0GrafLinea
  plot.setPoints(ad0GrafLinea);

  plot.addLayer("AD1", ad1GrafLinea);

  plot.addLayer("AD2", ad2GrafLinea);
  // Draw it!
  plot.activatePointLabels();
  plot.defaultDraw();

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
