import processing.serial.*;

boolean isOn = false;
Serial miPuerto;

void setup(){  
  miPuerto  = new Serial(this, "COM3", 9600);
  toggleScreen(isOn);  
  ledToggle(isOn);
}

void draw(){
  toggleScreen(isOn);
  ledToggle(isOn);
}

void keyPressed(){
  isOn = !isOn;
}

void toggleScreen(boolean isOn){
  if(isOn){
    background(0);
  }else{
    background(255);
  }
}

void ledToggle(boolean isOn){
  if(isOn){
    miPuerto.write("1\n");
  }else{
    miPuerto.write('1');
  }
}
