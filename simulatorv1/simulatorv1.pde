// use this to control the pixel pusher simulator display
import java.util.List;

int ledSpacer = 7;
int ledSize = 5;
int columns = 124;
int rows = 60;
color OFF = color(170,170,170);

// run once
void setup() {
  size(1500,500);
  // setup "processing" window to scrape our pixels from

  noFill();
  rect(0,0,620,300);
  fill(0);
  rect(620,0,2,500); // stage divider
  rect(0,300,620,200);
  // setup LED display - this will be out Pixel Pusher array simulator
  int x = 503; // topleft corner coordinates of the simulator window
  int y = 0; 
  
  
  identifyPanels(x + 130, y + 50);
  identifyPanels(x + 130 + (62 * ledSpacer), y + 50);
  buildCanopy(x + 130, y + 50);
  
  // now setup your PixelPushers
}

// run always
void draw() {
  noFill();
  stroke(255,0,0);
  ellipse(50,50,30,30);
  
  scrapePixels();
}

void scrapePixels() {
  
}

// ======================

class PixelPusher {
  private List<Strip> strips;
  public void PixelPusher(List<Strip> strips) {
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
  int posx = x;
  int posy = y;
  int lineCount = 0;
  int rowCount = 0;
  boolean stop = false;
   noStroke();
   fill(OFF);
   while (!stop) {
    ellipse(posx, posy, ledSize, ledSize);
    posx += ledSpacer;
    lineCount++;
    if (lineCount >= columns) {
      lineCount = 0;
      posy += ledSpacer;
      posx += (ledSpacer * -1 * columns);// - (ledSpacer / 2); // this additional shifts the lights in the original original parallelogram pattern
      rowCount++;
    }
    if (rowCount >= rows) {
      stop = true;
    }
  }
}

void identifyPanels(float x, float y) {
  float startX = x;
  float startY = y;
  boolean stop = false;
  noFill();
  int panels = 0;
  int count = 29;
  int degrees = 90;
  int rotNum = 0;

    beginShape();
    vertex(startX, startY);
    vertex(startX, startY + (count * ledSpacer));
    vertex(startX + count * ledSpacer, startY + (count * ledSpacer));
    endShape(CLOSE);
    
    startX = startX + ledSpacer;
    beginShape();
    vertex(startX, startY);
    vertex(startX + count * (ledSpacer), startY);
    vertex(startX + count * (ledSpacer), startY + (count * ledSpacer));
    endShape(CLOSE);
    
    startX = startX + ledSpacer + (count * ledSpacer);
    beginShape();
    vertex(startX, startY);
    vertex(startX + count * ledSpacer, startY);
    vertex(startX, startY + count * ledSpacer);
    endShape(CLOSE);
    
    startX = startX + ledSpacer + (count * ledSpacer);
    beginShape();
    vertex(startX, startY);
    vertex(startX, startY + count * ledSpacer);
    vertex(startX - count * ledSpacer, startY + count * ledSpacer);
    endShape(CLOSE);
    
    startX = x;
    startY = startY + ledSpacer + (count * ledSpacer);
    beginShape();
    vertex(startX, startY);
    vertex(startX + count * ledSpacer, startY);
    vertex(startX, startY + count * ledSpacer);
    endShape(CLOSE);
    
    startX = startX + ledSpacer + (count * ledSpacer);
    beginShape();
    vertex(startX, startY);
    vertex(startX, startY + count * ledSpacer);
    vertex(startX - count * ledSpacer, startY + count * ledSpacer);
    endShape(CLOSE);
    
    startX = startX + ledSpacer;
    beginShape();
    vertex(startX, startY);
    vertex(startX + count * ledSpacer, startY + count * ledSpacer);
    vertex(startX, startY + count * ledSpacer);
    endShape(CLOSE);
    
    startX = startX + ledSpacer;
    beginShape();
    vertex(startX, startY);
    vertex(startX + count * ledSpacer, startY);
    vertex(startX + count * ledSpacer, startY + count * ledSpacer);    
    endShape(CLOSE);
    
}