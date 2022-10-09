int num = 50;
float[] arrayOfFloats = new float[num];
 
void setup() {
  size(800,800);
  smooth();
}
 
void draw() {
  background(255);
 
  // copy everything one value down
  for (int i=0; i<arrayOfFloats.length-1; i++) {
    arrayOfFloats[i] = arrayOfFloats[i+1];
  }
 
  // new incoming value
  float newValue = noise(frameCount*0.01)*width;
 
  // set last value to the new value
  arrayOfFloats[arrayOfFloats.length-1] = newValue;
 
  // display all values however you want
  for (int i=0; i<arrayOfFloats.length; i++) {
    noStroke();
    fill(255,0,0,255);
    ellipse(width*i/arrayOfFloats.length+width/num/2,height-arrayOfFloats[i],width/num,width/num);
  }
}