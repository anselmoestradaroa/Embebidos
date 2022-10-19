import processing.serial.*;
import grafica.*;
Serial myPort;
int[] pilaDatos = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
GPlot plot3;// Grafico
GPointsArray puntos = new GPointsArray(pilaDatos.length);
int cantDatos = 0;

void setup(){
	size(800, 600);
// INICIALIZO EL GRAFICO
	plot3 = new GPlot(this);
	plot3.setPos(0, 0);
	plot3.setDim(600, 400);
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

	background(255);
	myPort = new Serial(this, Serial.list()[1], 9600);
	myPort.write("1\n");// escribo un uno para que empiece a enviar datos desde la RPIO
	myPort.bufferUntil(36);// Almacene en el buffer hasta el caracter $

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
	cantDatos++;
	background(255);
	int valorMedicion = int( p.readString().replace("$","") );// Paso el valor de la medida a entero
	int indice = (9 * valorMedicion)/65535;
	println("El valor de la medida " + cantDatos + " es : " + valorMedicion + " y se encuentra en el decil " + indice);
	pilaDatos[indice]++;
	imprimirArreglo(pilaDatos);

	puntos = new GPointsArray(pilaDatos.length);
	for(int i = 0; i < pilaDatos.length; i++)
		puntos.add(i, pilaDatos[i], "Decil " + i);
}

void imprimirArreglo(int[] a){
	for(int i = 0; i < a.length; i++)
		print(a[i] + " ");
	println();
}
