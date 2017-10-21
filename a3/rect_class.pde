class Rect{
  color c1,c2;
  float x, y;
  float wid, hgt;
  String data;
  boolean show_data;
  String name;
  
  public Rect(String data, String name){
    this.data = data;
    this.name = name;
    choose_color(data);
    this.c1 = color(0,0,255);
  }
  
  public boolean mouse_in(){
    return mouseX >= this.x && mouseX <= this.x+wid &&
           mouseY <= this.y && mouseY >= this.y+hgt;
  }
  
  void draw(){
    if(mouse_in()){
      stroke(c1);
      fill(c1);
      show_data = true;
    }else{
      stroke(c2);
      fill(c2);
      show_data = false;
    }
    rect(x, y, wid, hgt);    
  }
  
  void choose_color(String data) {
    float value = float(data);
    int i = 0;
    if (value >= 110 && value < 135.5) {
      i = int((value - 110) * 10);
      c2 = color(255 - i, 0,0);
    } else if (value >= 59) {
      i = int((110-value)*5);
      c2 = color(255,i,0);
    } else if (value >= 42) {
      i = int((59-value)*15);
      c2 = color(255-i,255,0);
    } else if (value >= 27) {
      i = int((42-value)*15);
      c2 = color(0,255,i);
    } else if (value >= -24) {
      i = int((27-value)*5);
      c2 = color(0,255-i,255);
    } else if (value >= -75) {
      i = int((-24-value)*5);
      c2 = color(0,0,255-i);
    } else c2 = color(255,255,255);
  }
}