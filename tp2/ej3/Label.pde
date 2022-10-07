
class Label{
  // Variables de clase
  private String label;
  private color labelColor;
  private int xPos;
  private int yPos;
  private int wLabel;
  private int hLabel;
  private int fontSize;
  // Constructor
  Label(){}
  Label(int x, int y, int w, int h, String l, color lc){
    label = l;
    labelColor = lc;
    xPos = x;
    yPos = y;
    wLabel = w;
    hLabel = h;
    fontSize = 12;
  }
  Label(int x, int y, int w, int h, String l, color lc, int fsize){
    label = l;
    labelColor = lc;
    xPos = x;
    yPos = y;
    wLabel = w;
    hLabel = h;
    fontSize = fsize;
  }
  
  // Getter
  String getTextLabel(){
    return label;
  }
  int getX(){
    return xPos;
  }
  int getY(){
    return yPos;
  }
  int getFontSize(){
    return fontSize;
  }
  
  // Setter
  void setTextLabel(String newLabel){
    label = newLabel;
  }
  void setX(int newX){
    xPos = newX;
  }
  void setY(int newY){
    yPos = newY;
  }
  void setColor(color newColor){
    labelColor = newColor;
  }
  void setFontSize(int fsize){
    fontSize = fsize;
  }
  
  // Métodos
  void display(){
    textAlign(CENTER, CENTER);
    fill(labelColor);
    textSize(fontSize);
    text(label, xPos, yPos, wLabel, hLabel);
  }
}
