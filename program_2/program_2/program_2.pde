int windowSize = 800;
IntList tempList;
int centerpoint = windowSize/2;
float angle = random(360);
float xScaler = random(10);
float yScaler = random(10);
float rScaler = random(3);

void setup() {
  size(800,800); 
  background(255, 255, 255);
  
  centerDot();
  readFile();
  for(int i = 0; i< tempList.size(); i++) {
    drawCircle(tempList.get(i));
  }
}

void draw() {

}

void centerDot() {
  fill(0,0,0);
  circle(windowSize/2,windowSize/2,1);
}

void dayColor() {
  fill(253, 184, 19);
}

void nightColor() {
  fill(140, 190, 214);
}

void drawCircle(int temp) {
  dayColor(); //should change based of when the temperature was taken.
  float xCircle = centerpoint+xScaler*(cos(angle)*temp);
  float yCircle = centerpoint+yScaler*(sin(angle)*temp);
  float rCircle = ((temp % 24)+1)*rScaler;
  
  stroke(253,184, 19, 70); 
  line(centerpoint,centerpoint,xCircle, yCircle);
  stroke(253,184, 19, 70); 
  circle(xCircle,yCircle, rCircle);
  
  angle = random(360);
  xScaler = random(10);
  yScaler = random(10);
  rScaler = random(3);
}

void readFile() {
  // Open the file from the createWriter() example 
  BufferedReader reader = createReader("forecastTemp.txt");
  String line = null;
  int temperature;
  tempList = new IntList();
  
  try {
      while ((line=reader.readLine())!=null) {
        temperature = int(line);
        tempList.append(temperature);
      }
      reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}
