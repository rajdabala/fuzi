public class Player {
  private PVector position, velocity, acceleration;
  private color c;
  private String name;
  private float s = 6;
  private float theta;
  private boolean inRange = false;
  private Player p;
  private int[] kickX = {width/2 + 50, width/2};
  private int[] kickY = {height/2, height/2 + 100};
    
  public Player (String n, int col, float x, float y, float dx, float dy, float ax, float ay) {
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
    name = n;
    c = colors[col];
  }
  
  public void update() {
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
  
  public void reset(ArrayList<soccer.Player> team) {
    inRange = false;
    for (int i = 0; i < team.size(); i++) {
      p = team.get(i);
      p.setX(kickX[i]);
      p.setY(kickY[i]);
      p.setDX(0);
      p.setDY(0);
      p.setAX(0);
      p.setAY(0);
    }
  }
  
  public void automate() {
    if (!inRange) {
      if(dist(keeps.getX(), keeps.getY(), getX(), getY()) >= 150) {
        setDX(0.0075*(keeps.getX() - getX()));
        setDY(0.0075*(keeps.getY() - getY()));
      } else {
        inRange = true;
        setDX(-0.015*(keeps.getX() - getX()));
        setDY(-0.015*(keeps.getY() - getY()));
      }
    }
    
    if(!inPos) {
      if (teamDist <= 15) {
        playSwitch();
      }
      setDX(0.05*(ball.getX() - getX()));
      setDY(0.05*(ball.getY() - getY()));
    }
  }
  
  public void draw() {
    theta = velocity.heading2D() + radians(90);
    
    fill(c);
    pushMatrix();
    translate(getX(), getY());
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -s*1.5);
    vertex(-s*1.25, s*1.5);
    vertex(s*1.25, s*1.5);
    endShape();
    popMatrix();
    
    textFont(pix);
    text(name, getX(), getY() + 20);
  }
}
