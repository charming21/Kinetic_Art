int windowSize = 600;
IntList tempList;
IntList timeList;
StringList shortForecastList;
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
  //code to draw the sun
  for(int i = 0; i < 10; i++){
    //sunny(random(-300,300), random(-300, 300));
      //cloudy(random(-300,300), random(-300, 300));    
  }
  fog(random(-300,300), random(-300, 300));
  for(int i = 0; i< tempList.size(); i++) {
    drawCircle(tempList.get(i), timeList.get(i));
  }
}

void draw() {

}

void fog(float row, float col) {
  cloudy(row, col);
  float distance = 20;
  float xPoint1 = row - distance*3;
  float yPoint1 = col + distance*1.7;
  float xPoint2 = xPoint1 + distance*5;
  float yPoint2 = yPoint1;
  
  //stroke(8);
  cloudColor();
  strokeWeight(4);
  line(xPoint1,yPoint1, xPoint2, yPoint2);
  line(xPoint1,yPoint1+distance/2, xPoint2, yPoint2+distance/2);

  
}

void cloudy(float row, float col) {
  float arcx = row;
  float arcy = col;
  float arcwidth = 50;
  float archeight = 50;
  float distance = arcwidth/2;

  float semiCirX = (arcx - distance*2 - arcwidth/2 + arcx + distance + arcwidth/2)/2;
  float semiCirY = arcy+distance;
  
  cloudColor();
  
  arc(arcx, arcy, arcwidth, archeight, PI+QUARTER_PI/2, PI+PI);
  arc(arcx - distance, arcy, arcwidth, archeight*.6, PI, PI+HALF_PI+QUARTER_PI*.3);
  arc(arcx - distance*2, arcy+distance, arcwidth, archeight, PI, PI+HALF_PI);
  arc(arcx + distance, arcy+distance, arcwidth, archeight, PI+HALF_PI/2, PI*2);
  arc(semiCirX, semiCirY, arcwidth*2, archeight*1.5, PI, PI*2);
  line(arcx - distance*2 - arcwidth/2, arcy+distance, arcx + distance + arcwidth/2, arcy+distance);
  
}

void sunny(float row, float col){
  float circlex = row;
  float circley = col;
  int circler = 15;
  float linestarts = 20;
  float lineends = linestarts*2;
  
  //Color of the Sun
  dayColor();
  circle(circlex, circley, circler);

  //Sun ray's thickness
  strokeWeight(3);
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
  stroke(253, 184, 19);
  strokeWeight(1);
}

void nightColor() {
  //fill(140, 190, 214);
  fill(34, 108, 224);
  stroke(34, 108, 224);
  strokeWeight(1);
}

void sunriseColor() {
  fill(255, 129, 0);
  stroke(255, 129, 0);
  strokeWeight(1);  
}

void sunsetColor() {
  fill(251,144,98);
  stroke(251,144,98);
  strokeWeight(1);

}

void cloudColor(){
  fill(236,240,241);
  stroke(236,240,241);
  strokeWeight(1);

}

void circleColor(int index){
  if(index < 5 || index > 20) {
    nightColor();
  }
  else if(index >= 5 && index <= 8 ) {
    sunriseColor();
  }
  else if(index >= 17 && index <= 20) {
    sunsetColor();
  }
  else if(index > 8 || index < 17) {
    dayColor();
  }
}

void drawCircle(int temp, int index) {
  
  float angle = radians(index * 15); 
  float xCircle = cos(angle) * time; 
  float yCircle = sin(angle) * time; 
  
  float rCircle = ((temp % 24)+1) * 1.25;
  
  circleColor(index);
  
  //stroke(253,184, 19, 70); 
  line(0,0,xCircle, yCircle);
  //stroke(253,184, 19, 70); 
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
  BufferedReader readerShortForecast = createReader("forecastShort.txt");

  String line = null;
  
  //for temp reading
  int temperature;
  tempList = new IntList();
  
  //for time reading
  int time;
  timeList = new IntList();
  
  //for shortforecast reading
  String shortForecast;
  shortForecastList = new StringList();
  
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
      }
     readerTime.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  
   try {
      while ((line = readerShortForecast.readLine())!=null) {
        shortForecast = line;
        shortForecastList.append(shortForecast);
        println(shortForecast);
      }
     readerShortForecast.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}
