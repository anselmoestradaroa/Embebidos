import grafica.*;
import java.util.Random;
public GPlot plot3;
public GPointsArray polygonPoints;
public float[] gaussianStack;
public int gaussianCounter;
public Random r;

public void setup() {
  size(850, 660);

  // Prepare the points for the third plot
  gaussianStack = new float[10];// en deciles
  gaussianCounter = 0;
  r = new Random();
  for (int i = 0; i < 20; i++) {
    int index = int(gaussianStack.length/2 + (float) r.nextGaussian());
    if (index >= 0 && index < gaussianStack.length) {
      gaussianStack[index]++;
      gaussianCounter++;
    }
  }
  
  GPointsArray points3 = new GPointsArray(gaussianStack.length);
  
  for (int i = 0; i < gaussianStack.length; i++) {
    points3.add(i + 0.5 - gaussianStack.length/2.0, gaussianStack[i]/gaussianCounter, "Percentil " + i);
  }
  
  // Setup for the third plot 
  plot3 = new GPlot(this);
  //plot3.setPos(0, 0);
  //plot3.setDim(600, 400);
  //plot3.setYLim(-0.02, 0.45);
  //plot3.setXLim(-5, 5);
  //plot3.getTitle().setText("Gaussian distribution (" + str(gaussianCounter) + " points)");
  //plot3.getTitle().setTextAlignment(LEFT);
  //plot3.getTitle().setRelativePos(0);
  //plot3.getYAxis().getAxisLabel().setText("Relative probability");
  //plot3.getYAxis().getAxisLabel().setTextAlignment(RIGHT);
  //plot3.getYAxis().getAxisLabel().setRelativePos(1);
  
  plot3.setPoints(points3);
  plot3.startHistograms(GPlot.VERTICAL);
  plot3.getHistogram().setDrawLabels(true);
  plot3.getHistogram().setRotateLabels(true);
  
  plot3.getHistogram().setBgColors(new color[] {
    color(0, 0, 255, 50), color(0, 0, 255, 100), 
    color(0, 0, 255, 150), color(0, 0, 255, 200)
  }
  );
}
public void draw() {
  background(255);
  // Add one more point to the gaussian stack
  int index = int(gaussianStack.length/2 + (float) r.nextGaussian());
  if (index >= 0 && index < gaussianStack.length) {
    gaussianStack[index]++;
    gaussianCounter++;
    
    GPointsArray points3 = new GPointsArray(gaussianStack.length);
    for (int i = 0; i < gaussianStack.length; i++) {
      points3.add(i + 0.5 - gaussianStack.length/2.0, gaussianStack[i]/gaussianCounter, "Decil " + i);
    }
    plot3.setPoints(points3);
    plot3.getTitle().setText("Gaussian distribution (" + str(gaussianCounter) + " points)");
  }
  // Draw the third plot  
  plot3.beginDraw();
  plot3.drawBackground();
  plot3.drawBox();
  plot3.drawYAxis();
  plot3.drawTitle();
  plot3.drawHistograms();
  plot3.endDraw();
}
