int windowSize = 800;
IntList tempList;
int centerpoint = windowSize/2;
float angle = random(360);
float xScaler = random(10);
float yScaler = random(10);
float rScaler = random(3);

int time = 50; // line length represents time? 50 is just a starting point

void setup() {
  size(800,800); 
  background(255, 255, 255);
  
  centerDot();
  readFile();
  translate(width / 2, height / 2); // Move the origin to the center of the canvas 
  for(int i = 0; i< tempList.size(); i++) {
    drawCircle(tempList.get(i), i);
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

void drawCircle(int temp, int index) {
  //dayColor(); //should change based of when the temperature was taken.
  //float xCircle = centerpoint+xScaler*(cos(angle)*temp);
  //float yCircle = centerpoint+yScaler*(sin(angle)*temp);
  //float rCircle = ((temp % 24)+1)*rScaler;
  
  //stroke(253,184, 19, 70); 
  //line(centerpoint,centerpoint,xCircle, yCircle);
  //stroke(253,184, 19, 70); 
  //circle(xCircle,yCircle, rCircle);
  
  //angle = random(360);
  //xScaler = random(10);
  //yScaler = random(10);
  //rScaler = random(3);
  
  dayColor(); //should change based of when the temperature was taken.
  float angle = radians(index * 15); 
  float xCircle = cos(angle) * time; 
  float yCircle = sin(angle) * time; 
    
  float rCircle = ((temp % 24)+1)*(temp/10) / 5;
    
  stroke(253,184, 19, 70); 
  line(0,0,xCircle, yCircle);
  stroke(253,184, 19, 70); 
  circle(xCircle,yCircle, rCircle);
  
  time += 1;
  
  // do something  special after each 24 temps idk
  if ((index + 1) % 24 == 0) {
        time += 10;
        //float diameter = dist(0, 0, xCircle+10, yCircle+10) * 2;
        //noFill(); // Set the fill color to transparent
        //stroke(0, 0, 255); // Set the stroke color to blue
        //ellipse(0, 0, diameter, diameter); 
   }
    
    
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
