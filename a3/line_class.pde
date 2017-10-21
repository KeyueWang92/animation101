class Line{
  float x1, y1, x2, y2, value1, value2, x, y;
  int index;
  int c1 = 255, c2 = 255, c3 = 255;
  color c;
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
    c = choose_color(Float.toString(value1));
    stroke(c);
    fill(c);
    ellipse(x,y,5,5);
  }
  
  color choose_color(String data) {
    float value = float(data);
    int i = 0;
    if (value >= 110 && value < 135.5) {
      i = int((value - 110) * 10);
      c = color(255 - i, 0,0);
    } else if (value >= 59) {
      i = int((110-value)*5);
      c = color(255,i,0);
    } else if (value >= 42) {
      i = int((59-value)*15);
      c = color(255-i,255,0);
    } else if (value >= 27) {
      i = int((42-value)*15);
      c = color(0,255,i);
    } else if (value >= -24) {
      i = int((27-value)*5);
      c = color(0,255-i,255);
    } else if (value >= -75) {
      i = int((-24-value)*5);
      c = color(0,0,255-i);
    } else c = color(255,255,255);
    return c;
  }
}