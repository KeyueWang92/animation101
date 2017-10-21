class Pie_char{
  float dia;
  float ratio, start_angle, end_angle;
  int num_slices;
  float x, y;
  String[] names; int[] values;
  //used for record the right ending position
  ArrayList<Slice> slices = new ArrayList<Slice>();
  //used for animations
  ArrayList<Slice> ss = new ArrayList<Slice>();
  boolean finish = false;
  float[] arc_reduce;
  
  Pie_char(String[] names, int[] values){
    this.names = names;
    this.values = values;
    x = 0.8*width/2;
    y = height/2;
    if (0.8*width > height){
      dia = height/2;
    }else{
      dia = 0.8*width/2;
    }
    ratio = 2*PI/total;
    arc_reduce = new float[names.length];
    for(int i=0; i<values.length;i++){      
      Slice s = new Slice(values[i]);
      Slice s1 = new Slice(values[i]);
      slices.add(s);
      ss.add(s1);
      arc_reduce[i] = values[i]*ratio/30;
    }
    arrange();
  }
  void arrange(){
    x = 0.8*width/2;
    y = height/2;
    if (0.8*width > height){
      dia = height/2;
    }else{
      dia = 0.8*width/2;
    }
    //initialize a pie chart
    start_angle = 0;
    for(int i=0;i<values.length;i++){
      end_angle = start_angle + values[i]*ratio;
      slices.get(i).setLoc(x, y, dia, dia, start_angle, end_angle);
      ss.get(i).setLoc(x, y, dia, dia, start_angle, start_angle);
      start_angle = end_angle;
      //println(arc_reduce.length, "-----", ss.size());
    }
  }
  
  String p_draw(String state){
    if(state == "PIE"){
      finish = false;
      this.arrange();
      for(Slice s:slices){
        s.draw(PIE);
      }
      return "PIE";
    }else if(state == "Pie_to_Bar"){
      if(finish){
        finish = false;
        return "BAR";
      }else{
        this.fade();
        for(Slice s:slices){
          s.draw(0);
        }
        return "Pie_to_Bar";
      }
    }else if(state == "Bar_to_Pie"){
      if(finish){
        finish = false;
        return "PIE";
      }else{
        this.grow();
        for(Slice s:ss){
          s.draw(0);
        }
        return "Bar_to_Pie";
      }
    }else if(state == "bar_PREPIE"){
      
    }
    return state;
  }
  void fade(){
    int i=0, all_finish=0;
    for(Slice s:slices){
      if(s.end <= slices.get(i).start){
          s.end = slices.get(i).start;
          all_finish++;
        }else{
          s.end -= arc_reduce[i];
        }
      i++;
    }
    if(all_finish == ss.size()){
      finish = true;
    }
  }
  void grow(){
    int j=0;
    int all_finish=0;
    for(Slice s:ss){
      if(s.end >= slices.get(j).end){
        s.end = slices.get(j).end;
        all_finish++;
      }else{
        println(j,"------");
        s.end += arc_reduce[j];
      }
      j++;
    }
    if(all_finish == ss.size()){
      finish = true;
    }
  }  
}