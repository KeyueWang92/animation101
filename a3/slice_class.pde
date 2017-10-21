class Slice{
  float x, y, value;
  float wid, hgt, start, end;
  
  Slice(float value){  
    this.value = value;
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
    if(mouse_in()){
      fill(100,149,237);
    }else{
      fill(160,160,160);
    }
    if(mode == PIE){
      fill(160,160,160);
    }else{
      noFill();
    }
    arc(x, y, wid, hgt, start, end, mode);
  }
  
}