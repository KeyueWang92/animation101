class Line{
  float x1, y1, x2, y2, value1, value2;
  int index;
  public Line(int index, float value1, float value2){
    this.index = index;
    this.value1 = value1;
    this.value2 = value2;
  }
  void draw(){
    fill(255,255,0);
    line(x1, y1, x2, y2);   
  }
}