String[] lines;
String[] headers;
String[] names;
int[] values;
int X_range;
int Y_range = 0;
float x_frame, y_frame, canvas1_w, canvas2_w;
float y_len, y_gap;
Bar_char barc;
Line_char linec;

void setup(){
  size(800,600);
  surface.setResizable(true);
  lines = loadStrings("./data.csv");
  headers = split(lines[0], ",");
  names = new String[lines.length - 1];
  values = new int[lines.length - 1];
  for(int i = 1; i < lines.length; i++){
    String[] data = split(lines[i], ",");
    names[i - 1] = data[0];
    values[i - 1] = int(data[1]);
    if(Y_range < values[i-1]){
      Y_range = values[i-1];
    }
  }
  barc = new Bar_char(names, values);
  linec = new Line_char(names, values);
}

void draw(){
  canvas2_w = 0.2 * width;
  canvas1_w = 0.8 * width;
  x_frame = canvas1_w*0.1;
  y_frame = height*0.1;
  y_len = 0.8*height;
  y_gap = 10*y_len/Y_range;
  //barc.arrange(); 
  linec.arrange();
  for(Line l: linec.lines){
    l.draw();
  }
}