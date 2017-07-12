// use this to control the pixel pusher simulator display
import java.util.List;

int ledSpacer = 7;
int ledSize = 5;
int columns = 124;
int rows = 60;
color OFF = color(170,170,170);
color DEAD = color(0,0,0);

int dispWidth = 200;
int dispHeight = 200;

// run once
void setup() {
  noSmooth(); // turn of anti-aliasing for 1-to-1 pixel color
  fill(0);
  size(1500,1000);
  fill(0);
  rect(0,0,1500,1000);
  fill(OFF);
  noStroke();
  rect(0,0,dispWidth,dispHeight);
  buildCanopy(1000,500);
}

int _tick = 0;

TestPattern pattern = new TestPattern();
void draw() {
  // speed control
  if (_tick % 2 == 0) {
    noStroke();
    // ==vvv= PATTERN DRAWING GOES HERE =vvv==
     pattern.run();
    // ==^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^==
  }
  
  // this maps directly to strips/rads
  // we'll need a function that converts strips/rads to pixel pusher arrays (e.g. 8 of 6 of 75);
  scrapePixels();
   _tick += 1;
}

void scrapePixels() {
  for (int y = 0; y < dispHeight; y++) {
    for (int x = 0; x < dispWidth; x++) {
       color c = get(x,y);
       if (c == OFF) continue;
       else {
         PolarCoord p = new PolarCoord(x,y);
         if (p.center) {
            // center of the canopy requires some thought
         } else {
           p.mapCanopy();
           // CONVERT strip to PixelPusher output (1 of 8) and led (1 of 450), with 75 out, then 75 in, 3 times over
           setColor(p.strip, p.led, c);
         } 
       }
    }
  }
}


void setColor(int strip, int led, color c) {
  if (led > 75 || led < 0) return; 
  if (strip < 0) strip += 96;
  pushMatrix();
  translate(1000,500);
  rotate(radians(strip * 3.75));
  fill(c);
  ellipse(0,((18 + led) * 5),3,3);
  popMatrix();
}

// ======================

void buildCanopy(int x, int y) {
  int totalStrips = 96;
  int totalLEDs = 75;
  int strips = 0;
  pushMatrix();
  translate(x, y);
  noFill();
  strokeWeight(1);
  stroke(150,150,150);
 
  while (strips < totalStrips) {
    int stripLeds = 0;
    while (stripLeds < totalLEDs) {
      ellipse(0, totalStrips + (5 * stripLeds), 3,3);
      stripLeds++;
    }
    strips++;
    rotate(radians((float)360/totalStrips));
  }
  fill(color(255,0,0));
  ellipse(0, (totalStrips - 5), 3, 3);
  popMatrix();
}