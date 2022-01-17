class Ball {
  float x = 100.0;
  float y = 180.0;
  float xspd = random(-5, 5);
  float yspd = -(sqrt(25-(xspd*xspd)));
  int size = 10;
  void display() {
    fill(0, 0, 255);
    ellipse(x, y, size, size);
  }
  void move() {
    x = x + xspd;
    y = y + yspd;
    if (x <= 5) {
      xspd = -xspd;
    }
    if (x >= (width-5)) {
      xspd = -xspd;
    }
    if (y <= 5) {
      yspd = -yspd;
    }
    if (180 <= y && y <= 195 && (mouseX - 50) <= x && x <= (mouseX + 50)) {
      xspd = random(-5, 5);
      yspd = -(abs(sqrt(25-sq(xspd))));
    }
  }
}

