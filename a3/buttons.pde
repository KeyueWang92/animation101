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
    fill(255,0,0);
    rect(x, y, wid, hgt);
    textAlign(CENTER, CENTER);
    fill(0,255,0);
    textSize(26); 
    text(text[0], x+wid/2,y+hgt/2);
    
    //button 2
    fill(0,255,0);
    rect(x, y+hgt, wid, hgt);
    fill(255,0,0);
    text(text[1], x+wid/2,y+hgt+hgt/2);
    
    //button 3
    fill(0,0,255);
    rect(x, y+2*hgt, wid, hgt);
    fill(0,255,0);
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