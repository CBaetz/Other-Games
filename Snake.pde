class Snake {
  String dir;
  ArrayList<Float> x, y;
  int sidelen;
  int len;
  ArrayList<Float> R, G, B;
  float r, g, b;
  Snake () {
    len = 1;
    dir = "right";
    x = new ArrayList();
    y = new ArrayList();
    R = new ArrayList();
    G = new ArrayList();
    B = new ArrayList();
    sidelen = 20;
    x.add(width/2.0 + 10);
    y.add(height/2.0 + 10);
    R.add(0.0);
    G.add(100.0);
    B.add(100.0);
  }
  void display() {
    for (int i = 0; i < len; i++) {
      fill(R.get(i), G.get(i), B.get(i));
      rect(x.get(i), y.get(i), sidelen, sidelen);
    }
  }
  void addColour() {
    R.add(len-1, r);
    if (len == 1){
    R.add(len-1, 0.0);
    }
    G.add(len-1, g);
    if (len == 1){
    G.add(len-1, 100.0);
    }
    B.add(len-1, b);
    if (len == 1){
    B.add(len-1, 100.0);
    }
    }
  
  void move() {
    for (int i = len -1; i > 0; i--) {
      x.set(i, x.get(i-1));
      y.set(i, y.get(i-1));
    }
    if (dir == "right") {
      x.set(0, x.get(0) + sidelen);
    }
    if (dir == "left") {
      x.set(0, x.get(0) - sidelen);
    }
    if (dir == "up") {
      y.set(0, y.get(0) - sidelen);
    }
    if (dir == "down") {
      y.set(0, y.get(0) + sidelen);
    }
    x.set(0, (x.get(0) + width) % width);
    y.set(0, (y.get(0) + height) % height);
    if (checkHit() == true) {
      float xtemp, ytemp;
      xtemp = x.get(0);
      ytemp = y.get(0);
      x.clear();
      y.clear();
      x.add(xtemp);
      y.add(ytemp);
      len = 1;
      R.clear();
      G.clear();
      B.clear();
      R.add(0.0);
      G.add(100.0);
      B.add(100.0);
    }
  }
  void addlink() {
    x.add(x.get(0) + sidelen);
    y.add(y.get(0) + sidelen);
    len ++;
  }
  boolean checkHit() {
    for (int i = 1; i< len; i++) {
      if (dist(x.get(0), y.get(0), x.get(i), y.get(i)) < sidelen) {
        return true;
      }
    }
    return false;
  }
  }


