// use this to control the pixel pusher simulator display
import java.util.List;

int ledSpacer = 7;
int ledSize = 5;
int columns = 124;
int rows = 60;
color OFF = color(170,170,170);

// run once
void setup() {
  size(1500,1000);
  // setup "processing" window to scrape our pixels from
  fill(OFF);
  noStroke();
  rect(0,0,501,501);
  // setup LED display - this will be our Pixel Pusher array simulator
  buildCanopy(1000,500);

}

void test() {
  
}

// run always
void draw() {
  fill(color(255,255,0));
  noStroke();
  rect(0,0,100,100);
  fill(color(11,178,220));
  ellipse(300,300,100,100);
  fill(color(0,118,111));
  beginShape();
  vertex(300,150);
  vertex(400,75);
  vertex(320,100);
  endShape(CLOSE);
  // this maps directly to strips/rads
  // we'll need a function that converts strips/rads to pixel pusher arrays (e.g. 8 of 6 of 75);
  scrapePixels();
 
}

void setColor(int strip, int led, color c) {
  pushMatrix();
  translate(1000,500);
  rotate(radians(strip * 3.75));
  fill(c);
  ellipse(0,96 + (led * 5),3,3);
  popMatrix();
}

void scrapePixels() {
  for (int y = 0; y < 500; y++) {
    for (int x = 0; x < 500; x++) {
      color c = get(x,y);
      if (c == OFF) { continue; }
      PolarCoord pc = new PolarCoord(x,y);
      int strip = floor(pc.theta * 180 / PI / 3.75);
      int r = floor(pc.radius * 75 / 500);
      setColor(strip, r, c);
    }
  }
}

// ======================
class PolarCoord {
  float theta;
  float radius;
  
  public PolarCoord(int x, int y) {
    int x2 = mapCartesianX(x);
    int y2 = mapCartesianY(y);
    this.theta = atan(y2 / (x2 + 0.01)) + PI;
    this.radius = sqrt((x2 * x2) + (y2 * y2));
  }
  
  public PolarCoord(float theta, float radius) {
    this.theta = theta;
    this.radius = radius;
  }
  
  public String toString() {
    return this.theta + "," + this.radius;
  }
  
  private int mapCartesianX(int x) {
    return x - 249;
  }
  
  private int mapCartesianY(int y) {
    return (y - 249) * -1;
  }
  
}

class PixelPusher {
  private List<Strip> strips;
  public PixelPusher(List<Strip> strips) {
    this.strips = strips;
  }
  
  public List<Strip> getStrips() {
    return this.strips;
  }
}

class Strip {
  private int NUMLEDS;
  private color[] LEDS;
  
  public void Strip(int num) {
    this.NUMLEDS = num;
    this.LEDS = new color[num];
  }
  
  public void setPixel(color c, int x) {
    this.LEDS[x] = c;
  }
  
}

// ======================

void buildCanopy(int x, int y) {
  int totalStrips = 96;
  int totalLEDs = 75;
  int strips = 0;
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
  translate(-1 * x,-1 * y);
}
