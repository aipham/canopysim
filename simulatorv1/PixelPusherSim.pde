class Canopy {
  PixelPusher p1;
  PixelPusher p2;
  
  public void Canopy() {
    ArrayList<Strip> ps1 = new ArrayList<Strip>();
    for (int i = 0; i < 8; i++) {
      ps1.add(new Strip(150));
    }
    ArrayList<Strip> ps2 = new ArrayList<Strip>();
    for (int i = 0; i < 8; i++) {
      ps2.add(new Strip(450));
    }
    
    this.p1 = new PixelPusher(ps1);
    this.p2 = new PixelPusher(ps2);
  }
  
  public void setRGB(int strip, int led, color c) {
    if (strip >= 48) {
      this.p2.setRGB(strip - 48, led, c);
    } else {
      this.p1.setRGB(strip, led, c);
    }
  }

}


public class PixelPusher {
  private List<Strip> strips; // max 8
  public PixelPusher(List<Strip> strips) {
    this.strips = strips;
  }
  
  public List<Strip> getStrips() {
    return this.strips;
  }
  
  public void setRGB(int strip, int led, color c) { // strip 0 - 47, led 0 - 74
    // find output pin (0 - 7)
    int pinOut = floor(strip / 6);
     int pixel = (((strip - pinOut * 6) - 1) * 75) + led;
    // a strip will go out-in-out-in-out-in, with each out/in contains 75 pixels
    // 0-74, 150-224, 300-374
    if ((led >= 0 && led <= 74) || (led >= 150 && led <= 224) || (led >= 300 && led <= 374)) {
    }
    // 75-149, 225-299, 374-449 // there are return trip pixels, and need to be adjusted
    else {
      if ((led >= 75 && led <= 149)) {
        pixel = 149 - pixel + 1;
      }
      if ((led >= 225 && led <= 299)) {
        pixel = 299 - pixel + 1;
      }
      if ((led >= 374 && led <= 449)) {
        pixel = 449 - pixel + 1;
      }
    }
    
    this.strips.get(pinOut).setPixel(pixel, c);
  }
}

class Strip {
  private int NUMLEDS;
  private color[] LEDS;
  
  public Strip(int num) {
    this.NUMLEDS = num;
    this.LEDS = new color[num];
  }
  
  public void setPixel(int x, color c) {
    this.LEDS[x] = c;
  }
  
}