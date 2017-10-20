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
    this.c1 = color(0,0,255);
    this.c2 = color(75,150,255);
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
}