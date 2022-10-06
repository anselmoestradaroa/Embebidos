int y = 0;
String s;

void setup() {
  surface.setTitle("Ejercicio 1 - Trabajo Práctico 2");
  size(640, 480); // Tamaño de la ventana
  loop();
}

void draw() { // LOOP, este bloque se repite
  background(150);// Gris
  line(120, y, 520, y);  
  y = y - 1; 
  if (y < 0) { 
    y = height; 
  } 
  s = "line(120, " + y +" , 520, " + y +");";
  fill(50);
  text(s, 10, 10, 120, 80);
} 
