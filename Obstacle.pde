class Obstacle {
  int x = 200;
  int oy = int(random(60, 140));
  int passes = 0;
  int highscore = 0;
  boolean range = false;
  void display() {
    fill(255, 255, 255);
    rect(x, 100, 20, 200);
    fill(0, 0, 0);
    rect(x, oy, 20, 60);
    x -= 3;
    if (x <= 0) {
      x = 200;
      oy = int(random(60, 140));
      passes ++;
    }
    if (passes > highscore) {
      highscore = passes;
    }
    if (x >= 50 && x <= 80) {
      range = true;
    } else {
      range = false;
    }
  }
}