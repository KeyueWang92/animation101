class Bar_char{
  float width_bar;
  float gap;
  String[] names;
  int[] values;
  ArrayList<Rect> rects = new ArrayList<Rect>();
  ArrayList<Rect> tran_rects = new ArrayList<Rect>();
  boolean finish = false;
  float[] hgt_reduce;
  
  Bar_char(String[] names, int[] values){
    this.names = names;
    this.values = values;
    for(int i=0; i<names.length; i++){
      Rect r= new Rect(Integer.toString(values[i]),names[i]);
      Rect r1= new Rect(Integer.toString(values[i]),names[i]);
      rects.add(r);
      tran_rects.add(r1);
    }
    this.hgt_reduce = new float[names.length];
  }
  
  void arrange(){ 
    //width_bar = 0.65*0.8*canvas1_w/names.length;
    //gap = 0.35*0.8*canvas1_w/names.length;
    int i = 0;
    for(Rect r:rects){
      //set rects to the right location
      r.x = x_frame+ (i+1)*gap + i*width_bar;
      r.y = height-y_frame;
      r.wid = width_bar;
      r.hgt = -height*0.8*values[i]/Y_range;
      hgt_reduce[i] = -r.hgt/30;
      i++;
    }

    // set transation rects to the top point
    i=0;
    for(Rect r:tran_rects){  
      r.wid = width_bar;
      r.hgt = -1;        
      r.x = x_frame+ (i+1)*gap + i*width_bar;
      r.y = height-y_frame - height*0.8*values[i]/Y_range - r.hgt;
      i++;
    }
  }
  
  String b_draw(String state){
    if(state == "BAR"){
      finish = false;
      this.arrange();
      for(Rect r:rects){
        r.draw();  
        if(r.show_data){
          fill(0);
          textSize(13);
          textAlign(CENTER, CENTER);
          text(r.data,r.x+width_bar/2, r.y+r.hgt-10);
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
      if(finish){
        finish = false;
        return "PIE";
      }else{
        for(Rect r:barc.rects){
          r.draw();
        }
        //this.to_line();
        this.fade();
        return "Bar_to_Pie";
      }
    }else if(state == "PREBAR"){
      if(finish){
        finish = false;
        return "BAR";
      }else{
        this.r_rect();
        for(Rect r:tran_rects){
          r.draw();
        }
        return "PREBAR";
      }
    }else if(state == "Pie_to_Bar"){
      if(finish){
        finish = false;
        return "BAR";
      }else{
        this.grow();
        for(Rect r:tran_rects){
          r.draw();
        }
        return "Pie_to_Bar";
      }
    }
    return state;
  }
  //void to_line(){
  //  for(Rect r:rects){
  //    if(r.wid <= 5){
  //      r.wid = 5;
  //      finish = true;
  //    }else{
  //      r.x = r.x + 1;
  //      r.wid = r.wid - 2;
  //    }
  //  }
  //}
  
  void r_rect(){
    boolean rec = false;
    for(Rect r:tran_rects){
      if(r.wid >= width_bar){
        r.wid = width_bar;
        rec = true;
      }else{
        r.x -= 1;
        r.wid += 2;
      }
    }
    if(rec){
      this.grow();
    }
  }
  void grow(){
    int j=0;
    int all_grown=0;
    for(Rect r:tran_rects){
      if(r.y >= rects.get(j).y){
        r.hgt = rects.get(j).hgt;
        r.y = rects.get(j).y;
        all_grown++;
      }else{
        r.y = r.y + hgt_reduce[j];
        r.hgt = r.hgt - hgt_reduce[j];
      }
      j++;
    }
    if(all_grown == tran_rects.size()){
      finish = true;
    }
  }
  void fade(){
    int j=0;
    int all_shrinked = 0;
    for(Rect r:rects){
      if(r.hgt >= -5){
        //r.y = r.y+5;
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