class Line_char{
  float width_bar;
  float gap;
  String[] names;
  int[] values;
  boolean finish = false;
  boolean growRect = false;
  float a,b = 0;
  int i = 0; 
  ArrayList<Line> lines = new ArrayList<Line>();
  Line_char(String[] names, int[] values){
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
      for(Line l:this.lines){
        l.c1 = 75;
        l.c2 = 150;
        l.c3 = 255;
        l.draw();
        l.draw_dot();
      }
      ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2+a, 5, 5);
      return "LINE";
    }else if(state == "Line_to_Bar"){
      if(this.finish){
        finish = false;
        return "PREBAR";
      }else{
        this.fade();
        return "Line_to_Bar";
      }
    }else if(state == "Line_to_Pie"){
      this.arrange();
      if(this.finish){
        i = 30;
        finish = false;
        return "PREPIE";
      }else{
        this.prepie();
        return "Line_to_Pie";
      }
    }else if(state == "PREPIE"){
      this.shrink();
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
    ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2+a, 5, 5);
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
      ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
    } 
    //from dot to vertical line
    else {
      if (i <= 30) {
        for (Line l: lines) {
          l.draw_dot();
          line(l.x1,l.y1,l.x1,l.y1+ (0.9 * height - l.y1) * i/30);
        }
        i++;
        ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
      }
      else if (i <= 45) {
        for (Line l: lines) {
          l.draw_dot();
          line(l.x1,l.y1,l.x1, l.y1 + (0.9 * height - l.y1));
        }
        i++;
        ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
      }
      else finish = true;
    }
  }
  
  void shrink(){
    if (i >= 0) {
      for (Line l: lines) {
        l.draw_dot();
        line(l.x1,l.y1,l.x1,l.y1+ (0.9 * height - l.y1) * i/30);
      }
      i--;
      ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
    }
    else {
      //for test
      for (Line l: lines) {
        l.draw_dot();
      }
      ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
    }
  }
  
  void fade(){
    if (this.lines.get(0).c1 < 255) {
      for (Line l: lines) {
        l.c1 = l.c1+6;
        l.c2 = l.c2+4;
        l.draw();
        l.draw_dot();
      }
      ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2, 5, 5);
    } else {
      if (a <= 2.5) {
        for (Line l: lines) {
          l.draw_dot();
          l.y += 0.5;
        }
        ellipse(lines.get(lines.size()-1).x2, lines.get(lines.size()-1).y2+a, 5, 5);
        a += 0.5;
      } else {
        fill(75,150,255);
        for (Line l: lines) {
          rect(l.x1-2.5,l.y1,5,5);
        }
        rect(lines.get(lines.size()-1).x2-2.5, lines.get(lines.size()-1).y2, 5, 5);
        finish = true;
      }
    } 
  }
}