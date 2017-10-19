class Line_char{
  float width_bar;
  float gap;
  String[] names;
  int[] values;
  ArrayList<Line> lines = new ArrayList<Line>();
  Line_char(String[] names, int[] values){
    this.names = names;
    this.values = values;
    for(int i=0; i<names.length - 1; i++){
      Line l= new Line(i, values[i], values[i+1]);
      lines.add(l);
      println(values[i+1]);
    }
  }
  
  void arrange(){
    fill(255);
    rect(0, 0, canvas1_w, height);    
    width_bar = 0.65*0.8*canvas1_w/names.length;
    gap = 0.35*0.8*canvas1_w/names.length;
    for(Line l:lines){
      l.x1 = x_frame+ (l.index+1)*gap + (l.index * width_bar) + width_bar/2;
      l.y1 = height - y_frame- height*0.8*l.value1/Y_range;
      l.x2 = l.x1 + gap + width_bar;
      l.y2 = height - y_frame - height*0.8*l.value2/Y_range;
    }
  }
}