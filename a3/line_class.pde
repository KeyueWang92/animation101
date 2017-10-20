class Line{
  float x1, y1, x2, y2, value1, value2, x, y;
  int index;
  int c1 = 255, c2 = 255, c3 = 255;
  public Line(int index, float value1, float value2){
    this.index = index;
    this.value1 = value1;
    this.value2 = value2;
  }
  void draw(){
    stroke(c1,c2,c3);
    line(x1, y1, x2, y2);  
  }
  
  void draw_dot(){
    stroke(75,150,255);
    fill(75,150,255);
    ellipse(x,y,5,5);
  }
}