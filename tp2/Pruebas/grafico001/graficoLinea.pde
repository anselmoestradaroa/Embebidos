int limit;
float x, y;

void setup() 
  {
  size(640, 480);
  textSize(24);
  }

void draw() 
  {
  background(255);
  
  stroke(128);
  strokeWeight(1);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
 
  limit++;                        //Increments each frame
  if (limit > width) limit = 0;  
  
  strokeWeight(3);
  stroke(255, 0, 0);
  for(int i = 0; i< limit; i++)
    {
    x = i*TAU/100;  
    y = 100*sin(x) + 50*cos(x/2);
    point(i, y + height/2);      // Points for now
    }
  
  fill(0);
  textAlign(LEFT, CENTER);
  text(y, limit+10, y + height/2);  
  }