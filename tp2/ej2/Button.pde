
class Button{
  // Variables de clase
  private int x, y, w, h;
  private color bgColor;
  private Label label;
  // Constructor
  Button(){}
  Button(int xPos, int yPos, int _width, int _height, color bgc, String l, color lc){
    x = xPos;
    y = yPos;
    w = _width;
    h = _height;
    bgColor = bgc;
    label = new Label(x, y, w, h, l, lc);    
  }
  // Getter
  Label getLabel(){
    return label;
  }
  String getTextLabel(){
    return label.getTextLabel();
  }
  // Setter
  void setBgColor(color c){
    bgColor = c;
  }
  void setLabelColor(color c){
    label.setColor(c);
  }
  void setTextLabel(String newtextLabel){
    label.setTextLabel(newtextLabel);
  }

  // Metodos
  void display(){
      fill(bgColor);
      rect(float(x),float(y),float(w),float(h));
      label.display();
  }
}
