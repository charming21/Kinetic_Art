int windowSize = 600;
IntList tempList;
IntList timeList;
int centerpoint = windowSize/2;
float angle = random(360);
float xScaler = random(10);
float yScaler = random(10);
float rScaler = random(3);

int time = 60; // line length represents time? 50 is just a starting point

void setup() {
  size(600,600); 
  background(255, 255, 255);
  
  centerDot();
  readFile();
  translate(width / 2, height / 2); // Move the origin to the center of the canvas 
  for(int i = 0; i < 10; i++){
  sunny(random(-300,300), random(-300, 300));
  }
  //for(int i = 0; i< tempList.size(); i++) {
  //  drawCircle(tempList.get(i), timeList.get(i));
  //}
}

void draw() {

}

void sunny(float row, float col){
  float circlex = row;
  float circley = col;
  int circler = 15;
  float linestarts = 20;
  float lineends = linestarts*2;
  
  //fill(0,0,0);
  fill(253, 184, 19);
  circle(circlex, circley, circler);
  //top
  line(circlex,circley - linestarts,circlex , circley - lineends);
  //bottom
  line(circlex,circley + linestarts,circlex , circley + lineends);
  //left
  line(circlex - linestarts,circley,circlex - lineends, circley);
  //right
  line(circlex + linestarts,circley,circlex + lineends, circley);
  
  //top-right corner
  line(circlex + linestarts*.6, circley - linestarts*.6, circlex + lineends*.6, circley - lineends*.6);
  //bottom-right corner
  line(circlex + linestarts*.6, circley + linestarts*.6, circlex + lineends*.6, circley + lineends*.6);
  //top-left corner
  line(circlex - linestarts*.6, circley - linestarts*.6, circlex - lineends*.6, circley - lineends*.6);
  //bottom-left corner
  line(circlex - linestarts*.6, circley + linestarts*.6, circlex - lineends*.6, circley + lineends*.6);
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
  
  //dayColor(); //should change based of when the temperature was taken.
  float angle = radians(index * 15); 
  float xCircle = cos(angle) * time; 
  float yCircle = sin(angle) * time; 
  
  float rCircle = ((temp % 24)+1)*(temp/10) / 5;
  
  if(index < 6 || index > 18) {
    nightColor();
  }
  else {
    dayColor();
  }
  
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
  BufferedReader readerTemp = createReader("forecastTemp.txt");
  BufferedReader readerTime = createReader("forecastTime.txt");

  String line = null;
  
  //for temp reading
  int temperature;
  tempList = new IntList();
  
  //for time reading
  int time;
  timeList = new IntList();
  
  try {
      while ((line=readerTemp.readLine())!=null) {
        temperature = int(line);
        tempList.append(temperature);
      }
     readerTemp.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  
  try {
      while ((line = readerTime.readLine())!=null) {
        time = int(line);
        timeList.append(time);
        println(time);
      }
     readerTime.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}
