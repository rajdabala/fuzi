public class Ball {
  private PVector position, velocity, acceleration;
  private color col = color(0, 0, 0);
  
  public Ball (float x, float y, float dx, float dy, float ax, float ay) {
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
  }
  
  public void update() {
    // ball movement
    velocity.add(acceleration);
    position.add(velocity);
    
    setAX(-0.04 * getDX());
    setAY(-0.04 * getDY());
  }
  
  public float getX() {
    return position.x;
  }
  
  public float getY() {
    return position.y;
  }
  
  public void setX(float x) {
    position.x = x;
  }
  
  public void setY(float y) {
    position.y = y;
  }
  
  public float getDX() {
    return velocity.x;
  }
  
  public float getDY() {
    return velocity.y;
  }
  
  public void setDX(float dx) {
    velocity.x = dx;
  }
  
  public void setDY(float dy) {
    velocity.y = dy;
  }
  
  public float getAX() {
    return acceleration.x;
  }
  
  public float getAY() {
    return acceleration.y;
  }
  
  public void setAX(float ax) {
    acceleration.x = ax;
  }
  
  public void setAY(float ay) {
    acceleration.y = ay;
  }
  
  public void dribble() {
    if(playDist <= 15) {
      setDX(user.getDX() * 1.1);
      setDY(user.getDY() * 1.1);
    }
  }
  
  public void block() {
    if(keepDist <= 30) {
      setDX(0.05 * (user.getX() - getX()));
      setDY(0.05 * (user.getY() - getY()));
    }
  }
  
  public void shoot() {
    setDX(0.05 * ((float)(Math.random() * goalOut) - getX()));
    setDY(0.05 * ((float)(Math.random() * (goalLowBound - goalUpBound) + goalUpBound) - getY()));
  }
  
  public void pass() {
    setDX(0.05 * (tm.getX() - getX()));
    setDY(0.05 * (tm.getY() - getY()));
  }
  
  public void setColor(color c) {
    col = c;
  }
  
  private void reset() {
    setX(width/2);
    setY(height/2);
    setDX(0);
    setDY(0);
    setAX(0);
    setAY(0);
  }
  
  public void draw() {
    fill(col);
    ellipse(position.x, position.y, 7, 7);
  }
}
