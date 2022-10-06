float x = 170;
float y = 150;
float w = 100;
float h = 100;
Boolean isOn = false;
String txtIsOff = "El fondo es Negro ";
String txtIsOn  = "El fondo es Blanco";
void setup(){  
    surface.setTitle("Ejercicio 2 - Trabajo Práctico 2");
    size(640, 480);    
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
  if(isOn){
    println("IsON = True");    
    background(255);// Fondo Blanco    
    fill(0); // Color del relleno del botón  
    rect( x , y , w , h , 30);// Botón
    text(txtIsOn, 40, 40, 280, 320);
  }else{
    println("IsON = False");    
    background(0);// Fondo negro     
    fill(255); // Color del relleno del botón
    rect( x , y , w , h , 30);// Botón
    text(txtIsOff, 40, 40, 280, 320); 
  }
}
