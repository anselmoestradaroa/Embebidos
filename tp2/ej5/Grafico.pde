class Grafico{
  String xlabel, ylabel, title, type;
  int xPos, yPos, w, h, idType, res;
  String[] type = {"Línea", "Barra", "Torta"};

  int[] data;
  
  // Contructor 
  Grafico(int xPos, int yPos, int w, int h, String title){
    this.title = title;
    this.xPos = xPos;
    this.yPos = yPos;
    this.w = w;
    this.h = h;
    res = int(this.w / 10);// delta t in pix

  }
  
  // Create a line graph
  void createLineal(String xl, String yl, Boolean isGridOn){
    gridOn(isGridOn);
    xlabel = xl;
    ylabel = yl;
    idType = 0 ;// because it is a line graph    
  }
  void createLineal(String xl, String yl){
    createLineal(xl, yl, false);
  }  
  
  // Create a bar graph
  void createBar(String xl, String yl, Boolean isGridOn){
    gridOn(isGridOn);
    xlabel = xl;
    ylabel = yl;
    idType = 1 ;// because it is a bar graph
  }  
  void createBar(String xl, String yl){
    createBar(xl, yl, false);
  }


  // Create a pie chart
  void createPie(int percentile){
    //int dat[percentile];

    
    idType = 2 ;// because it is a pie chart
  }

  private void gridOn(Boolean isGridOn){
    if(isGridOn){
      println("La grilla está activada");
    }else{
      println("La grila está desactivada");
    }
  }

  void addData(int data){
    /* Segun el tipo de grafico     */
    /* realiza distintas operacione */
  }

  private void addDataLineal(int data){
    // Solo tienes que dibujarlo
    // Ya que el punto se va moviendo con el tiempo
  }
  
}
