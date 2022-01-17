Ball ball;
Paddle1 paddle1;
Paddle2 paddle2;
int Score = 0;
int temp = 0;
void setup() {
  size(400, 300);
  frameRate(50);
  ellipseMode(CENTER);
  rectMode(CENTER);
  ball = new Ball();
  paddle1 = new Paddle1();
  paddle2 = new Paddle2();
}
void draw() {
  background(0, 0, 0);
  paddle1.display();
  paddle2.display();
  ball.move();
  ball.display();
  if (ball.x < 25) {
    ball.Reset();
    Score--;
  }
  if (ball.x > 375) {
    ball.Reset();
    temp++;
    if (temp == 5) {
      Score++;
      temp = 0;
    }
  }
  textSize(32);
  fill(255, 255, 255);
  text(Score, 200, 150);
}