class Food {
  float x, y;
  int size;
  float R = int(random(255));
  float B = int(random(255));
  float G = int(random(255));
  float rtemp, btemp, gtemp;
  Food() {
    rtemp = 0.0;
    btemp = 100.0;
    gtemp = 100.0;
    reset();
  }
  void display() {
    fill(R, G, B);
    ellipse(x, y, size, size);
  }
  void reset() {
    rtemp = R;
    btemp = B;
    gtemp = G;
    R = int(random(255));
    B = int(random(255));
    G = int(random(255));
    size = 20;
    x = 20 * int(random(0, width) / 20) + 10;
    y = 20 * int(random(0, height)/ 20) + 10;
    snake.r = rtemp;
    snake.g = gtemp;
    snake.b = btemp;
    snake.addColour();
  }
}

