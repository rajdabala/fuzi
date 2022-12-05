// fuzi by raj

Ball ball;
Goalie keeps;
ArrayList<Player> team = new ArrayList<>();
Player user, tm;
color[] colors = {color(255, 0, 0), color(0, 0, 255), color(255, 255, 0)};
float magnitude, playDist, teamDist, keepDist, goalLowBound, goalUpBound, boxLowBound, boxUpBound, goalOut, boxOut, midY;
int score = 0;
boolean inPos, goalScreen, dribby = true;
float speed, topspeed, sprint;
PFont pix, pixB;

void setup() {
  fullScreen();
  noCursor();

  // creating field dimensions
  midY = height/2;
  goalLowBound = midY + height * 0.12191999609;
  goalUpBound = midY - height * 0.12191999609;
  goalOut = width * 0.04987655552;
  boxLowBound = midY + height * 0.26822399141;
  boxUpBound = midY - height * 0.26822399141;
  boxOut = width * 0.14962966657;

  // making ball and team (players)
  ball = new Ball(width/2, height/2, 0, 0, 0, 0);
  keeps = new Goalie("raj", 2, goalOut + 25, midY, 0, 2, 0, 0);
  team.add(new Player("viv", 1, width/2 + 50, height/2, 0, 0, 0, 0));
  team.add(new Player("nubz", 1, width/2, height / 2 + 100, 0, 0, 0, 0));
  user = team.get(0);
  tm = team.get(1);

  pix = createFont("slkscre.ttf", 12);
  pixB = createFont("slkscreb.ttf", 12);

  // speed variable to make it easy to change
  speed = 2;
  topspeed = 5;
}

void draw() {
  // checks for possession
  if (playDist <= 100) {
    inPos = true;
  } else {
    inPos = false;
  }

  // calculates the distance of player and teammate
  playDist = dist(ball.getX(), ball.getY(), user.getX(), user.getY());
  teamDist = dist(ball.getX(), ball.getY(), tm.getX(), tm.getY());
  keepDist = dist(ball.getX(), ball.getY(), keeps.getX(), keeps.getY());

  // creating field
  noFill();
  background(46, 181, 46);
  stroke(255, 255, 255);
  // goal
  strokeWeight(5);
  line(0, goalUpBound, goalOut, goalUpBound);
  line(0, goalLowBound, goalOut, goalLowBound);
  strokeWeight(1);
  // goal netting
  for (int i = 0; i <= goalOut; i += 7) {
    line(i, goalUpBound, i, goalLowBound);
  }
  for (int j = (int)goalUpBound; j <= goalLowBound; j += 7) {
    line(0, j, goalOut, j);
  }
  // goalbox
  strokeWeight(2);
  line(0, boxUpBound, boxOut, boxUpBound);
  line(0, boxLowBound, boxOut, boxLowBound);
  line(boxOut, boxUpBound, boxOut, boxLowBound);
  arc(width * 0.09975311105, midY, width * 0.16625518508, height * 0.24383999219, -0.585*HALF_PI, 0.585*HALF_PI);
  noStroke();

  //prints score
  fill(255, 255, 255);
  textFont(pix);
  textSize(20);
  text("score: " + score, width - 125, 20);

  // draw team and ball
  user.draw();
  keeps.draw();
  tm.draw();
  ball.draw();

  // dribble detection
  ball.dribble();

  // goalie blocking
  ball.block();

  // teammate behavior
  tm.automate();

  // keep ball in bounds
  if (width < ball.getX() || ball.getX() < 0 || ball.getY() < 0 || ball.getY() > height) {
    fill(0, 0, 0);
    rect(0, 0, width, height);
    textFont(pixB);
    textSize(25);
    textAlign(CENTER);
    fill(255, 255, 0);
    text("OUT OF BOUNDS", width/2, height/2);
    if (keyPressed && key == ' ') {
      reset();
    }
  }

  // goal detection
  if (goalUpBound < ball.getY() && goalLowBound > ball.getY() && ball.getX() < goalOut + 5) {
    ball.setDX(0);
    ball.setDY(0);
    ball.setAX(0);
    ball.setAY(0);
    fill(0, 0, 0);
    rect(0, 0, width, height);
    textFont(pixB);
    textSize(25);
    textAlign(CENTER);
    fill(255, 255, 0);
    text("GOAL", width/2, height/2);
    textSize(20);
    text("score: " + (score + 1), width/2, height/2 + 20);
    if (keyPressed && key == ' ') {
      score++;
      reset();
    }
  }

  // move the ball/player and account for friction
  ball.update();
  keeps.update();
  user.update();
  tm.update();
}

void keyPressed() {
  // controls
  if (abs(user.getDX()) < topspeed && abs(user.getDY()) < topspeed) {
    if (key == 'w') {
      user.setDY(user.getDY() - speed);
    }
    if (key == 's') {
      user.setDY(user.getDY() + speed);
    }
    if (key == 'a') {
      user.setDX(user.getDX() - speed);
    }
    if (key == 'd') {
      user.setDX(user.getDX() + speed);
    }
  }
  if (key == 'q') { //change key to mouseClick later on
    if (playDist < 50) {
      ball.pass();
      playSwitch();
    } else {
      stroke(255, 0, 0);
      line(user.getX() + 10, user.getY() - 20, user.getX() + 20, user.getY() - 10);
      line(user.getX() + 20, user.getY() - 20, user.getX() + 10, user.getY() - 10);
    }
  }
  if (key == ' ') {
    if (playDist < 50 && dist(0, midY, user.getX(), user.getY()) < 500) {
      ball.shoot();
    } else {
      stroke(255, 0, 0);
      line(user.getX() + 10, user.getY() - 20, user.getX() + 20, user.getY() - 10);
      line(user.getX() + 20, user.getY() - 20, user.getX() + 10, user.getY() - 10);
    }
  }
}

void playSwitch() {
  // switch players method
  user = team.get(1 - team.indexOf(user));
  tm = team.get(1 - team.indexOf(tm));
}

void reset() {
  goalScreen = false;
  user.reset(team);
  ball.reset();
  keeps.reset();
  user = team.get(0);
  tm = team.get(1);
  inPos = true;
  textSize(12);
}
