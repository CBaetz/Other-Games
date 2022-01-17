class Paddle2 {
  float temp = 0.0;
  void display () {
    fill(0, 255, 0);
    rect(350, 150+(100*sin(temp)), 10, 100);
    temp+=0.1;
  }
}