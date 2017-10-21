String[] lines;
String[] headers;
String[] names;
float[] values;
int X_range;
float Y_range = 0;
float total = 0;
float x_frame, y_frame, canvas1_w, canvas2_w;
float y_len, y_gap;
Bar_char barc;
Line_char linec;
Pie_char piec;
Button buttons;
String state = "PIE";

void setup(){
  frameRate(10);
  size(1000,600);
  surface.setResizable(true);
  lines = loadStrings("./data.csv");
  headers = split(lines[0], ",");
  names = new String[lines.length - 1];
  values = new float[lines.length - 1];
  for(int i = 1; i < lines.length; i++){
    String[] data = split(lines[i], ",");
    names[i - 1] = data[0];
    values[i - 1] = float(data[1]);
    if(Y_range < values[i-1]){
      Y_range = values[i-1];
    }
    total += values[i-1];
  }
  barc = new Bar_char(names, values);
  linec = new Line_char(names, values);
  piec = new Pie_char(names, values);
  buttons  = new Button();
  barc.arrange();piec.arrange();
}

void axis(){
  stroke(0);
  textAlign(LEFT);
  textSize(12);
  // add the x-axis names
  for(int i=0;i<names.length; i++){   
    pushMatrix();
    translate(x_frame+ (i+1)*barc.gap + i*barc.width_bar, height-y_frame+10);
    rotate(radians(45));
    fill(0);
    text(names[i], 0,0);
    popMatrix(); 
  }
  
  // add the y-axis lines
  float temp = height-y_frame;
  int y_mark = 0; 
  while(temp >= 0.1*height){
    line(x_frame, temp, width-x_frame+20-canvas2_w, temp);
    fill(0);
    text(Integer.toString(y_mark*10), x_frame-0.045*canvas1_w, temp);
    y_mark ++;
    temp -= y_gap;
  }  
  
  line(x_frame, height-y_frame, x_frame, temp);
  // add the x-y-labels
  fill(25,25,112); text(headers[0], canvas1_w/2, height*0.99);
  pushMatrix();
  translate(0.025*canvas1_w, 0.5*height);
  rotate(radians(270));
  text(headers[1], 0,0);
  popMatrix(); 
}

void draw(){ 
  canvas2_w = 0.2*width;
  canvas1_w = 0.8*width;
  x_frame = canvas1_w*0.1;
  y_frame = height*0.1;
  y_len = 0.8*height;
  y_gap = 10*y_len/Y_range;
  barc.width_bar = 0.65*0.8*canvas1_w/names.length;
  barc.gap = 0.35*0.8*canvas1_w/names.length;
  fill(255);
  rect(0, 0, canvas1_w, height);

  //if(!(state == "PIE" || state == "PREPIE")){
  if(state != "PIE"){
    axis();
  }
  buttons.setLoc(canvas1_w, 0, canvas2_w, height/3);
  buttons.bdraw();
  state = barc.b_draw(state);
  state = linec.l_draw(state);
  state = piec.p_draw(state);

}

void mouseClicked(){
  String next = buttons.buttonClicked();

  if(state == "BAR"){
    barc.arrange();piec.arrange();
    if(next == "LINE"){
      state = "Bar_to_Line";
    }else if(next == "PIE"){
      state = "Bar_to_Pie";
    }
  }else if(state == "LINE"){
    barc.arrange();piec.arrange();
    if(next == "BAR"){
      state = "Line_to_Bar";
    }else if(next == "PIE"){
      state = "PREPIE";
    }
  }else if(state == "PIE"){
    barc.arrange();piec.arrange();
    if(next == "BAR"){
      state = "Pie_to_Bar";
    }else if(next == "LINE"){
      state = "Pie_to_Line";
    }
  }
  println(state,"++++++");
}