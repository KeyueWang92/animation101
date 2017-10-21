class Button{
  float x, y, wid, hgt, i=0;
  String[] text;
  Button(){
     this.text = new String[] {"Bar","Line","Pie"};
  }
  
  void setLoc(float x, float y, float wid, float hgt){
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hgt = hgt;
  }
  void bdraw(){
    //button 1
    if (mouseX >= x && mouseX <= (x + wid) && mouseY >= y && mouseY < (y+hgt)) {
      stroke(200,160,200);
      fill(140,160,200);
    } else {
    stroke(170,200,240);
    fill(170,200,240);
    }
    rect(x, y, wid, hgt);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(26); 
    text(text[0], x+wid/2,y+hgt/2);
    
    //button 2
    if (mouseX >= x && mouseX <= (x + wid) && mouseY >= (y+hgt) && mouseY < (y+2*hgt)) {
      stroke(140,160,200);
      fill(140,160,200);
    } else {
    stroke(170,200,240);
    fill(170,200,240);
    }
    rect(x, y+hgt, wid, hgt);
    fill(255,255,255);
    text(text[1], x+wid/2,y+hgt+hgt/2);
    
    //button 3
    if (mouseX >= x && mouseX <= (x + wid) && mouseY >= (y+2*hgt) && mouseY < (y+3*hgt)) {
      stroke(140,160,200);
      fill(140,160,200);
    } else {
    stroke(170,200,240);
    fill(170,200,240);
    }
    rect(x, y+2*hgt, wid, hgt);
    fill(255,255,255);
    text(text[2], x+wid/2,y+2*hgt+hgt/2);
  }
  
  String buttonClicked(){
    if(mouseX >= x && mouseX <= width &&
        mouseY >= 0 && mouseY <= hgt){
        return "BAR";
      }else if(mouseX >= x && mouseX <= width &&
        mouseY >= hgt && mouseY <= hgt*2){
        return "LINE";
      }else if(mouseX >= x && mouseX <= width &&
        mouseY >= hgt*2 && mouseY <= hgt*3){
        return "PIE";
      }
      return "";
  }
}