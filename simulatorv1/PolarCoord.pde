// ======================
class PolarCoord {
  boolean center = false;
  
  float theta;
  float radius;
  
  int strip;
  int led;
  
  public PolarCoord(int x, int y) {
    int x2 = mapCartesianX(x);
    int y2 = mapCartesianY(y);
    if (x2 == 0) {
      if (y2 > 0) { this.theta = PI/2; }
      if (y2 == 0) { 
        this.theta = 0; 
        this.center = true; // special rules for mapping to canopy
      }
      if (y2 < 0) { this.theta = -PI/2; }
    } 
    else {
      this.theta = atan2(y2, x2);
    }
    this.radius = sqrt(x2 * x2 + y2 * y2);
  }
  
  public PolarCoord(float theta, float radius) {
    this.theta = theta;
    this.radius = radius;
  }
  
  public String toString() {
    return this.theta + "," + this.radius;
  }
  
  public void mapCanopy() {
    float thetaDegrees = this.theta * 180 / PI;
    // CONVERT TO CANOPY LAYOUT which is ass backwards
    thetaDegrees = (thetaDegrees + 90) * -1;
    if (thetaDegrees < 0) { thetaDegrees += 360; }
    this.strip = round(thetaDegrees * 96 / 360); 
    this.led = round(this.radius * 75 / dispWidth * 2);
    
  }
  
  private int mapCartesianX(int x) {
    return x - dispWidth / 2;
  }
  
  private int mapCartesianY(int y) {
    return (y - dispHeight / 2) * -1;
  }
  
}