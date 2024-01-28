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
  //for(int i = 0; i < 10; i++){
  //  sunny(random(-300,300), random(-300, 300));
  //}
  //cloudy();
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
  stroke(253, 184, 19);
}

void nightColor() {
  //fill(140, 190, 214);
  fill(34, 108, 224);
  stroke(34, 108, 224);
}

void sunriseColor() {
  fill(255, 129, 0);
  stroke(255, 129, 0);
}

void sunsetColor() {
  fill(251,144,98);
  stroke(251,144,98);
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
