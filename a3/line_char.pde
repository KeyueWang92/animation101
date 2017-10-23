class Line_char{
  float width_bar;
  float gap;
  String[] names;
  float[] values;
  boolean finish = false;
  boolean growRect = false;
  float a,b = 0;
  int i = 0; 
  ArrayList<Line> lines = new ArrayList<Line>();
  Line_char(String[] names, float[] values){
    this.names = names;
    this.values = values;
    for(int i=0; i<names.length - 1; i++){
      Line l= new Line(i, values[i], values[i+1]);
      lines.add(l);
    }
  }
  
  void arrange(){  
    width_bar = 0.65*0.8*canvas1_w/names.length;
    gap = 0.35*0.8*canvas1_w/names.length;
    for(Line l:lines){
      l.x1 = x_frame+ (l.index+1)*gap + (l.index * width_bar) + width_bar/2;
      l.y1 = height - y_frame- height*0.8*l.value1/Y_range;
      l.x2 = l.x1 + gap + width_bar;
      l.y2 = height - y_frame - height*0.8*l.value2/Y_range;
      l.x = l.x1;
      l.y = l.y1;
    }
  }
 
  String l_draw(String state){
    if(state == "PRELINE"){
      this.arrange();
      if (lines.get(0).c1 != 75) {
        preline();
        return "PRELINE";
      }
      else {
        return "LINE";
      }
    }
    else if(state == "LINE"){
      this.arrange();
      i = 0;
      for(Line l:this.lines){
        l.c1 = 75;
        l.c2 = 150;
        l.c3 = 255;
        l.draw();
        l.draw_dot();
      }
      set_last_color();
      if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        }
      else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2+a, 5, 5);
      return "LINE";
    }else if(state == "Line_to_Bar"){
      if(this.finish){
        finish = false;
        return "PREBAR";
      }else{
        this.fade();
        return "Line_to_Bar";
      }
    }else if(state == "PREPIE"){
      this.arrange();
      if(this.finish){
        i = 20;
        finish = false;
        return "Line_to_Pie";
      }else{
        this.prepie();
        return "PREPIE";
      }
    }else if(state == "Line_to_Pie"){
      if (finish) {
        finish = false;
        return "PIE";
      }
      else {
        this.shrink();
        return "Line_to_Pie";
      }
    }else if(state == "Pie_to_Line"){
      this.arrange();
      if(finish){
        finish = false;
        return "pie_PRELINE";
      }else{
        this.grow();
        return "Pie_to_Line";
      }
    }else if(state == "pie_PRELINE"){
      if(finish){
        finish = false;
        return "PRELINE";
      }else{
        this.shrink();
        return "pie_PRELINE";
      }
    }
    return state;
  }
  
  void preline() {
    for (Line l: lines) {
      l.c1 = l.c1-6;
      l.c2 = l.c2-4;
      l.draw();
      l.draw_dot();
    }
    set_last_color();
    if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        }
    else  ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2+a, 5, 5);
  }
  
  void prepie() {
    //from line to dot
    if (this.lines.get(0).c1 < 255) {
      for (Line l: lines) {
        l.c1 = l.c1+6;
        l.c2 = l.c2+4;
        l.draw();
        l.draw_dot();
      }
      set_last_color();
      if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        }
      else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
    } 
    //from dot to vertical line
    else {
      if (i <= 20) {
        for (Line l: lines) {
          l.draw_dot();
          line(l.x1,l.y1,l.x1,l.y1 + (0.9 * height - l.y1) * i/20);
        }
        set_last_color();
        if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        } else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
        
        line(lines.get(lines.size()-1).x2,lines.get(lines.size()-1).y2,
        lines.get(lines.size()-1).x2,lines.get(lines.size()-1).y2+ 
        (0.9 * height - lines.get(lines.size()-1).y2) * i/20);
        i++;
      }
      else finish = true;
    }
  }
  
  void shrink(){
    if (i >= 0) {
      for (Line l: lines) {
        l.draw_dot();
        line(l.x1,l.y1,l.x1,l.y1 + (0.9 * height - l.y1) * i/20);
      }
      set_last_color();
      if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        } else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
      line(lines.get(lines.size()-1).x2,lines.get(lines.size()-1).y2,
        lines.get(lines.size()-1).x2,lines.get(lines.size()-1).y2+ 
        (0.9 * height - lines.get(lines.size()-1).y2) * i/20);
      i--;
    }
      else finish = true;
    
  }
  
  void grow(){
    if (i <= 20) {
      for (Line l: lines) {
        l.draw_dot();
        line(l.x1,0.9*height,l.x1,0.9*height - (0.9 * height - l.y1) * i/20);
      }
      set_last_color();
      if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        } else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
      line(lines.get(lines.size()-1).x2,0.9*height,
        lines.get(lines.size()-1).x2,0.9*height- 
        (0.9 * height - lines.get(lines.size()-1).y2) * i/20);
      i++;
    }
      else finish = true;
  }
  
  void fade(){
    if (this.lines.get(0).c1 < 255) {
      for (Line l: lines) {
        l.c1 = l.c1+6;
        l.c2 = l.c2+4;
        l.draw();
        l.draw_dot();
      }
      set_last_color();
      if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        } else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
    } else {
      if (a <= 2.5) {
        for (Line l: lines) {
          l.draw_dot();
          l.y += 0.5;
        }
        set_last_color();
        if (mouseX >= lines.get(lines.size()-1).x2 - 10 && mouseX <= lines.get(lines.size()-1).x2 + 10 
        && mouseY >= lines.get(lines.size()-1).y2 - 10 && mouseY <= lines.get(lines.size()-1).y2 + 10){
        stroke(0,0,255);
        fill(0,0,255);
        textSize(13);
        textAlign(CENTER, CENTER);
        text(""+lines.get(lines.size()-1).value2,mouseX,mouseY);
        } else ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2+a, 5, 5);
        a += 0.5;
      } else {
        fill(75,150,255);
        for (Line l: lines) {
          rect(l.x1-2.5,l.y1,5,5);
        }
        set_last_color();
        rect(lines.get(lines.size()-1).x2-2.5, lines.get(lines.size()-1).y2, 5, 5);
        finish = true;
      }
    } 
  }
  
  void set_last_color(){
    Line l = lines.get(lines.size()-1);
    color c = l.choose_color(Float.toString(l.value2));
    stroke(c);
    fill(c);
  }
}