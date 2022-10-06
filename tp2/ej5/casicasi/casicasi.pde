import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph 
int yPos = 1;

//Variables to draw a continuous line.
int lastxPos=1;
int lastheight=0;

void setup () {
  // set the window size:
  size(1000, 800);// List all the available serial ports
  //println(Serial.list());
  // Check the listed serial ports in your machine
  // and use the correct index number in Serial.list()[].
  myPort = new Serial(this, Serial.list()[1], 9600);  //
  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('$');
  background(255);      // set inital background:
  stroke(127,34,255);     //stroke color
  strokeWeight(4);        //stroke wider
}
void draw () {
   // background(255);      // set inital background:
  // everything happens in the serialEvent()
  circle(xPos, yPos, 5);
  
    line(lastxPos, lastheight, xPos, yPos);
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('$');
  if (inString != null){
    circle(xPos, yPos, 5);
    //inString = trim(inString);                // trim off whitespaces.
    float inByte = float(inString.replace("$",""));           // convert to a number.
    println("El valor del puerto serial es " + inByte);    
    inByte = map(inByte, 0, 65535, 0, height); //map to the screen height.
    //Drawing a line from Last inByte to the new one.
    stroke(127,34,255);     //stroke color
    strokeWeight(4);        //stroke wider
    //yPos = height - inByte;
    yPos = height - int(inByte);
    println("x1 " + lastxPos + "\ny1 " + lastheight + "\nx2 " + xPos + "\ny2 " + yPos );
    lastxPos= xPos*20;
    lastheight = int(height-inByte);
    
    // at the edge of the window, go back to the beginning:
    if (xPos >= width) {
    xPos = 0;
    lastxPos= 0;
    background(0);  //Clear the screen.
    }else{
      // increment the horizontal position:
      xPos++;
    }
  }
}
