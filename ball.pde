class Ball {
  float x = 100.0;
  float y = 150.0;
  float yspd = random(-4, 4);
  float xspd = sqrt(25-(yspd*yspd));
  float temp = 0.0;
  void display() {
    fill(0, 0, 255);
    ellipse(x, y, 20, 20);
  }
  void move() {
    x = x + xspd;
    y = y + yspd;
    if (y <= 10) {
      yspd = -yspd;
    }
    if (y >= 290) {
      yspd = -yspd;
    }
    if (40 <= x && x <= 60 && y > mouseY-50 && y < mouseY + 50 ) {
      yspd = random(-4, 4);
      xspd = abs(sqrt(25-sq(yspd)));
    }
    if (x <= 360 && x >= 340 && y > 150+(100*sin(temp))-50 && y < 150+(100*sin(temp)) + 50) {
      yspd = random(-4, 4);
      xspd = -abs(sqrt(25-sq(yspd)));
    }
    temp += 0.1;
  }
  void Reset() {
    x = 100.0;
    y = 150.0;
    yspd = random(-4, 4);
    xspd = sqrt(25-(yspd*yspd));
  }
}