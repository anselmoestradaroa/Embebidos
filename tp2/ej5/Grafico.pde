
class Grafico{
  String xlabel, ylabel, title;
  int xPos, yPos, w, h;
  
  // Contructor
  Grafico(String xl, String yl, String title, int xPos, int yPos, int w, int h){
    xlabel = xl;
    ylabel = yl;
    this.title = title;
    this.xPos = xPos;
    this.yPos = yPos;
    this.w = w;
    this.h = h;
  }

  void linea(Boolean gridOn){
    line(120, 80, 340, 300);
  }
}
