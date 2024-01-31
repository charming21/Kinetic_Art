int windowSize = 600;
IntList tempList;
IntList timeList;
StringList shortForecastList;
int centerpoint = windowSize / 2;

float time = 100;
int currentTemp = 0;
String currentForecast = "none";
int click = 0;

ArrayList<Circle> circles = new ArrayList<Circle>();
class Circle {
    float x, y;   
    float radius;  
    int temp;
    String description;
    
    Circle() {
    }
    Circle(float x, float y, float radius, int temp, String description) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.temp = temp;
        this.description = description;
    }
}

// replace clicking with hovering
//void mousePressed() {
//  float x = mouseX - width / 2;
//  float y = mouseY - height / 2;

//  for (Circle circle : circles) {
//    if (isPointInsideCircle(x, y, circle.x, circle.y, circle.radius)) {
//      currentTemp = circle.temp;
//      currentForecast = circle.description;
//      click = 1;
//     } 
//  }
//}

void setup() {
    size(800,800); 
    background(135, 206, 235);
    basicBackground();
}

int start = 1;
int rain = 0;
int sunny = 0;
int cloudy = 0;
int Setup = 0;
int fog = 0;
int inCircle = 0;
float brightness = 0;
float brightnessChange = 1;
FloatList cordList = new FloatList();
Circle currCircle = new Circle();

void draw() {
    
    float x = mouseX - width / 2;
    float y = mouseY - height / 2;
    
    if (inCircle == 0) {
        for (Circle circle : circles) {
            if (isPointInsideCircle(x, y, circle.x, circle.y, circle.radius)) {
                inCircle =1;
                currCircle= circle;
                currentTemp = circle.temp;
                currentForecast = circle.description; 
                click = 1;
            } 
        }
    }
    
    if (inCircle == 1) {
        if (!isPointInsideCircle(x, y, currCircle.x, currCircle.y, currCircle.radius)) {
            inCircle = 0;
            currCircle = new Circle();
        }
    }
    
    if (click == 1) {
        // reset backgrounds:
        rain= 0;
        sunny = 0;
        cloudy = 0;
        Setup = 0;
        fog = 0;
        brightness = 0;
        
        // set new background: 
        if (currentForecast.indexOf("Rain") != -1) { // equal
            rain = 1; 
        } 
        if (currentForecast.indexOf("Sunny") != -1) { // equal
            sunny = 1;
            Setup = 1;
        } 
        if (currentForecast.indexOf("Cloudy") != -1) { // equal
            cloudy = 1;
            Setup = 1;
        } 
        if (currentForecast.indexOf("Fog") != -1) { // equal
           fog = 1;
           Setup = 1;
        } 
        if (currentForecast.indexOf("null") != -1) { // equal
            background(135, 206, 235);
            basicBackground();
        } 
        
        // text
        //fill(0);
        //textSize(16);
        //text("temp: " + currentTemp, 10  - width / 2, 20 - height / 2);
        click = 0;   
    }
    
    if (rain == 1) {
        background(0, 0, 100);
        basicBackground();
        for (int i = 0; i < 100; i++) {
            float x_cord = random( - width / 2, width / 2); // Random x-coordinate
            float y_cord = random( - height / 2, height / 2); // Random y-coordinate
            drawRaindrop(x_cord, y_cord);
        }
        delay(60);
    }
    
    if (sunny == 1) {
      if (Setup == 1) {
        for (int i = 0; i < 10; i++) {
            float x_cord = random( - 300,300);
            float y_cord = random( - 300,300);
            sunny(x_cord, y_cord);
            cordList.append(x_cord);
            cordList.append(y_cord);
        }
        Setup = 0;
      }
      
      background(135, 206, 235);
      basicBackground();
      
      // add effect to sun
      for (int i = 0; i < 40; i+=2) {
        float sun_x = cordList.get(i);
        float sun_y = cordList.get(i + 1);
        brightness += brightnessChange;
        delay(2);
        if (brightness > 255 || brightness < 0) {
            brightnessChange *= -1; // Reverse the direction if out of bounds
         }
         fill(255, 255, 0, brightness);
         noStroke();
         float currentBrightness = map(brightness, 0, 255, 10, 100);
         ellipse(sun_x, sun_y, currentBrightness, currentBrightness);
        sunny(sun_x, sun_y);
      }
      
    }
    
    if (cloudy == 1) {
        if (Setup == 1) {
          cordList.clear();
          for (int i = 0; i < 50; i++) {
            float x_cord = random( - width / 2, width / 2); // Random x-coordinate
            float y_cord = random( - height / 2, height / 2); // Random y-coordinate
            cordList.append(x_cord);
            cordList.append(y_cord);
          }
          Setup = 0;
        }
        background(224, 224, 224);
        basicBackground();
        for (int i = 0; i < 50; i+=2) {
          float cloud_x = cordList.get(i);
          float cloud_y = cordList.get(i + 1);
          
          cloudy(cloud_x, cloud_y);
          
          if (cloud_x < -300) {
              cloud_x = width; // Reset to the right side of the screen
              cordList.set(i, cloud_x);
          } else {
              cordList.set(i, cloud_x - 2);
          }
        }        
    }
    
    if (fog == 1) {
        if (Setup == 1) {
          cordList.clear();
          for (int i = 0; i < 40; i++) {
            float x_cord = random( - width / 2, width / 2); // Random x-coordinate
            float y_cord = random( - height / 2, height / 2); // Random y-coordinate
            cordList.append(x_cord);
            cordList.append(y_cord);
          }
          Setup = 0;
        }
        background(204, 224, 255);
        basicBackground();

        // foggy effect
        for (int i = 0; i < 100; i++) {
            float fog_x = random(-300, 300);
            float fog_y = random(-300, 300);
            float fog_radius = random(0, 600);
            float fog_transparency = random(5, 15);
            fill(204, 224, 255, fog_transparency);
            noStroke();
            ellipse(fog_x, fog_y, fog_radius, fog_radius);
        }
    
        for (int i = 0; i < 40; i+=2) {
          float cloud_x = cordList.get(i);
          float cloud_y = cordList.get(i + 1);
          
          fog(cloud_x, cloud_y);
          
          if (cloud_y < -300) {
              cloud_y = width; 
              cordList.set(i + 1, cloud_y);
          } else {
              cordList.set(i + 1, cloud_y - 2);
          }
        }        
    }
}

void drawRaindrop(float x, float y) {
    stroke(138, 43, 226); 
    line(x, y, x, y + 10);
}

void fog(float row, float col) {
    cloudy(row, col);
    float distance = 20;
    float xPoint1 = row - distance * 3;
    float yPoint1 = col + distance * 1.7;
    float xPoint2 = xPoint1 + distance * 5;
    float yPoint2 = yPoint1;
    
    cloudColor();
    strokeWeight(4);
    line(xPoint1,yPoint1, xPoint2, yPoint2);
    line(xPoint1,yPoint1 + distance / 2, xPoint2, yPoint2 + distance / 2);
}

void cloudy(float row, float col) {
    float arcx = row;
    float arcy = col;
    float arcwidth = 50;
    float archeight = 50;
    float distance = arcwidth / 2;
    
    float semiCirX = (arcx - distance * 2 - arcwidth / 2 + arcx + distance + arcwidth / 2) / 2;
    float semiCirY = arcy + distance;
    
    cloudColor();
    
    arc(arcx, arcy, arcwidth, archeight, PI + QUARTER_PI / 2, PI + PI);
    arc(arcx - distance, arcy, arcwidth, archeight * .6, PI, PI + HALF_PI + QUARTER_PI * .3);
    arc(arcx - distance * 2, arcy + distance, arcwidth, archeight, PI, PI + HALF_PI);
    arc(arcx + distance, arcy + distance, arcwidth, archeight, PI + HALF_PI / 2, PI * 2);
    arc(semiCirX, semiCirY, arcwidth * 2, archeight * 1.5, PI, PI * 2);
    line(arcx - distance * 2 - arcwidth / 2, arcy + distance, arcx + distance + arcwidth / 2, arcy + distance);
    
}

void sunny(float row, float col) {
    float circlex = row;
    float circley = col;
    int circler = 15;
    float linestarts = 20;
    float lineends = linestarts * 2;
    
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
    line(circlex + linestarts * .6, circley - linestarts * .6, circlex + lineends * .6, circley - lineends * .6);
    //bottom-right corner
    line(circlex + linestarts * .6, circley + linestarts * .6, circlex + lineends * .6, circley + lineends * .6);
    //top-left corner
    line(circlex - linestarts * .6, circley - linestarts * .6, circlex - lineends * .6, circley - lineends * .6);
    //bottom-left corner
    line(circlex - linestarts * .6, circley + linestarts * .6, circlex - lineends * .6, circley + lineends * .6);
}

void centerDot() {
    fill(0,0,0);
    circle(windowSize / 2,windowSize / 2,1);
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

void cloudColor() {
    fill(236,240,241);
    stroke(236,240,241);
    strokeWeight(1);
    
}

void circleColor(int index) {
    if (index < 5 || index > 20) {
        nightColor();
    }
    else if (index == 5) {
        fill(255,77,0);
        stroke(255,77,0);
        strokeWeight(1);
    }
    else if (index == 6) {
        fill(255,103,0);
        stroke(255,103,0);
        strokeWeight(1);
    }
    else if (index == 7) {
        fill(255,129,0);
        stroke(255,129,0);
        strokeWeight(1);
    }
    else if (index == 8) {
        fill(255,167,0);
        stroke(255,167,0);
        strokeWeight(1);
    }
    else if (index == 17) {
        fill(238,175,97);
        stroke(238,175,97);
        strokeWeight(1);
    }
    else if (index == 18) {
        fill(251,144,98);
        stroke(251,144,98);
        strokeWeight(1);
    }
    else if (index == 19) {
        fill(238,93,108);
        stroke(238,93,108);
        strokeWeight(1);
    }
    else if (index == 20) {
        fill(206,73,147);
        stroke(206,73,147);
        strokeWeight(1);
    }
    else if (index > 8 || index < 17) {
        dayColor();   
    }
}

void drawCircle(int temp, int index, String description) {
    float angle = radians(index * 15); 
    float xCircle = cos(angle) * time; 
    float yCircle = sin(angle) * time; 
    float rCircle = ((temp % 24) + 1) * 1.4;
    
    Circle circle = new Circle(xCircle, yCircle, rCircle, temp, description);
    circles.add(circle);
    
    circleColor(index);
    
    line(0,0,xCircle, yCircle); 
    circle(xCircle,yCircle, rCircle);
    
    time = time + 1.5;
    if ((index + 1) % 24 == 0) {
        time += 7;
    }    
}

boolean isPointInsideCircle(float x, float y, float circleX, float circleY, float circleRadius) {
    float distance = dist(x, y, circleX, circleY);
    return distance < circleRadius;
}

void readFile() {
    //Open the file from the createWriter() example 
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
        while ((line = readerTemp.readLine())!= null) {
            temperature = int(line);
            tempList.append(temperature);
        }
        readerTemp.close();
        } catch (IOException e) {
            e.printStackTrace();
          }
    
    try {
        while ((line = readerTime.readLine())!= null) {
            time= int(line);
            timeList.append(time);
        }
        readerTime.close();
        } catch (IOException e) {
            e.printStackTrace();
          }
    
    try {
        while ((line = readerShortForecast.readLine())!= null) {
            shortForecast = line;
            shortForecastList.append(shortForecast);
        }
        readerShortForecast.close();
        } catch(IOException e) {
              e.printStackTrace();
          }
}

void basicBackground() {
    readFile();
    centerDot();
    translate(width / 2, height / 2); // Move the origin to the center of the canvas 
    circles = new ArrayList<Circle>();
    time = 70;
    for (int i = 0; i < tempList.size(); i++) {
        drawCircle(tempList.get(i), timeList.get(i), shortForecastList.get(i));
    }
    //the reset circle
    Circle circle = new Circle(0, 0, 20, 0, "null");
    circles.add(circle);
    fill(255,255,255);
    stroke(255,255,255);
    strokeWeight(1);
    circle(0,0,20);
    
}
