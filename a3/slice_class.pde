class Slice{
  float x, y, value;
  String x_label;
  float wid, hgt, start, end;
  color c;
  boolean show_data;
  
  Slice(String label, float value){  
    this.x_label = label;
    this.value = value;
    c = choose_color(Float.toString(value));
  }
  
  void setLoc(float x, float y, float wid, float hgt, float start, float end){
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hgt = hgt;
    this.start = start;
    this.end = end;
  }
  
  boolean mouse_in(){  
    float angle = atan2(mouseY - y, mouseX - x);  
    if(angle < 0){
      angle += 2*PI;
    }   
    return sq(mouseX-x)+sq(mouseY-y) <= sq(wid/2) &&
            angle >= start && angle <= end;
  }
  
  void draw(int mode){
    if(mode == PIE && !mouse_in()){
      stroke(255);
      fill(c);
      this.show_data = false;
    }else if(mode == PIE && mouse_in()){
      stroke(230,230,255);
      fill(230,230,255);
      this.show_data = true;     
    }else{
      this.show_data = false;
      noFill();
      strokeWeight(10);
    }
    arc(x, y, wid, hgt, start, end, mode);
    strokeWeight(1);
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