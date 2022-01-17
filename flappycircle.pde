Ball ball;
Obstacle obst;
void setup() {
  size(200, 200);
  ellipseMode(CENTER);
  frameRate(40);
  rectMode(CENTER);
  ball = new Ball();
  obst = new Obstacle();
}
void draw() {
  background(0, 0, 0);
  obst.display();
  ball.display();
}