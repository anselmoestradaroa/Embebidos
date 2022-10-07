int w = 100;
int h = 100;
// Para que el boton este centrado
int x = 640/2 - w/2;
int y = 480/2 - h/x;
Boolean isOn = false;
String txtBotonOn = "¡Tocame!\nO.O";
String txtBotonOff = "¡Tocame!\n>.O";
String txtHelp  = "Haz click en el botón para cambiar entre negro y blanco el color del fondo de la pantalla";
color blanco = color(255);
color negro = color(0);
Label miLabel = new Label(0, 0, 640, 90, txtHelp, 128, 30);

void setup(){  
    surface.setTitle("Ejercicio 2 - Trabajo Práctico 2");
    size(640, 480);  
    background(negro);
    bgToggle(isOn);
}
void draw(){}

void mousePressed() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
        isOn = !isOn;
        bgToggle(isOn);
    }
}

void bgToggle(Boolean isOn){
  Button miBoton = new Button(x, y, w, h, blanco, txtBotonOff, negro);
  if(isOn){
    //println("IsON = True\nPantalla blanca");   
    background(blanco);// Fondo Blanco
    miBoton.setBgColor(negro);
    miBoton.setTextLabel(txtBotonOn);
    miBoton.setLabelColor(blanco);
  }else{
    //println("IsON = False\nPantalla negra");   
    background(negro);// Fondo negro  
    miBoton.setBgColor(blanco);    
    miBoton.setTextLabel(txtBotonOff);
    miBoton.setLabelColor(negro);
  }  
  miBoton.display();
  miLabel.display();
}
