Ball ball;
Paddle paddle;
int Score = 0;
void setup() {
  size(200, 200);
  frameRate(50);
  ellipseMode(CENTER);
  rectMode(CENTER);
  ball = new Ball();
  paddle = new Paddle();
}
void draw() {
  background(0, 0, 0);
  paddle.display();
  ball.move();
  ball.display();
  if (ball.y > 200) {
    new Ball();
  }
}

