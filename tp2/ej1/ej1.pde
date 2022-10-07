int y = 0;
String s;

void setup() {
  surface.setTitle("Ejercicio 1 - Trabajo Práctico 2");// Título de la ventana
  size(640, 480); // Tamaño de la ventana
}

void draw() { // LOOP, este bloque se repite
  background(150);// Color del fondo: Gris
  stroke(204, 102, 0);// Color de la linea, las lineas no usan fill para ser pintadas
  line(120, y, 520, y);// Tamaño de la linea definida por dos puntos
  y = y - 1; // Resto en 1 al valor de la variable y
  if (y < 0) { // Si y es menos que cero vuelvo la variable y al valor del alto de la ventana
    y = height; 
  } 
  s = "line(120, " + y +" , 520, " + y +");";//String en ventana que muestra como se modifica el valor de la linea 
  fill(255);// Color del texto: blanco
  text(s, 10, 10, 120, 80);// imprimo el texto en pantalla
} 
