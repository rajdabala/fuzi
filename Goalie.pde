public class Goalie {
  private PVector position, velocity, acceleration;
  private boolean keepsInGoal;
  private color c;
  private String name;
  
  public Goalie (String n, int col, float x, float y, float dx, float dy, float ax, float ay) {
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
    name = n;
    c = colors[col];
  }
  
  public void update() {
    if (keeps.getY() > goalUpBound - 10 && keeps.getY() < goalLowBound + 10) {
      keepsInGoal = true;
    } else {
      keepsInGoal = false;
    }
    
    position.add(velocity);
    setDY(0.075 * (float)(ball.getY() - getY()));
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
  
  public void reset() {
    setX(goalOut + 10);
    setY(midY);
    setDX(0);
    setDY(2);
  }
  
  public void draw() {
    fill(c);
    rect(getX(), getY(), 20, 20);
    text(name, getX() + 5, getY() + 35);
  }
}
