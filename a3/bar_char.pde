class Bar_char{
  float width_bar;
  float gap;
  String[] names;
  int[] values;
  ArrayList<Rect> rects = new ArrayList<Rect>();
  boolean finish = false;
  float[] hgt_reduce;
  
  Bar_char(String[] names, int[] values){
    this.names = names;
    this.values = values;
    for(int i=0; i<names.length; i++){
      Rect r= new Rect(Integer.toString(values[i]),names[i]);
      rects.add(r);
    }
    this.hgt_reduce = new float[names.length];
  }
  
  void arrange(){ 
    width_bar = 0.65*0.8*canvas1_w/names.length;
    gap = 0.35*0.8*canvas1_w/names.length;
    int i = 0;
    for(Rect r:rects){
      r.x = x_frame+ (i+1)*gap + i*width_bar;
      r.y = height-y_frame;
      r.wid = width_bar;
      r.hgt = -height*0.8*values[i]/Y_range;
      hgt_reduce[i] = -r.hgt/30;
      i++;
    }
    //printArray(hgt_reduce);
  }
  
  String b_draw(String state){
    if(state == "BAR"){
      this.arrange();
      for(Rect r:barc.rects){
        r.draw();  
        if(r.show_data){
          fill(0);
          text(r.data,r.x, r.y+r.hgt-10);
        }
      }
      return state;
    }else if(state == "Bar_to_Line"){
      if(finish){
        finish = false;
        return "PRELINE";
      }else{
        for(Rect r:barc.rects){
          r.draw();
        }
        this.fade();
        return "Bar_to_Line";
      }
    }else if(state == "Bar_to_Pie"){
    }else if(state == "PREBAR"){
      if(finish){
        finish = false;
        return "BAR";
      }else{
        this.grow();
        for(Rect r:rects){
          r.draw();
        }
        return "PREBAR";
      }
    }
    return state;
  }
  void grow(){
    int j=0;
    int all_grown=0;
    for(Rect r:rects){
      if(-r.hgt >= int(r.data)){
        r.hgt = -int(r.data);
        all_grown++;
      }else{
        r.y = r.y + hgt_reduce[j];
        r.hgt = r.hgt - hgt_reduce[j];
      }
      j++;
    }
    if(all_grown == rects.size()){
      finish = true;
    }
  }
  void fade(){
    int j=0;
    int all_shrinked = 0;
    for(Rect r:rects){
      if(r.hgt >= -5){
        //r.y = height-y_frame -10;
        r.hgt = -5;
        all_shrinked++;
      }else{     
        r.y = r.y - hgt_reduce[j];
        r.hgt = r.hgt + hgt_reduce[j];
      }
      j++;
    }
    
    if(all_shrinked == rects.size()){
      this.r_dot();
    }
  }
  
  void r_dot(){
    for(Rect r:rects){
      if(r.wid <=5){
        r.wid = 5;
        finish = true;
      }else{
        r.x += 1;
        r.wid -= 2;
      }
    }
  }

}