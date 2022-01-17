class Ball {
  float y = 100;
  float change = -8;
  int deaths = 0;
  void display() {
    fill(0, 255, 255);
    ellipse(60, y, 10, 10);
    y += change;
    change += 0.75;
    if (keyPressed == true) {
      change = -6;
    }
    if (y >= 200 || y <= 0) {
      reset();
    }
    if (obst.range == true && (y <= (obst.oy - 25) || y >= (obst.oy + 25))) {
      reset();
      obst.x = 200;
      obst.oy = int(random(60, 140));
    }
    fill(255, 0, 0);
    textSize(40);
    text(deaths, 110, 40);
    fill(0, 255, 0);
    text(obst.passes, 50, 40);
  }
  void reset() {
    y = 100;
    change = -8;
    deaths++;
    obst.passes = 0;
    if (deaths == 10) {
      exit();
      println("CONGLATURATIONS!!!");
      println("YOU GOT A HIGH-SCORE OF");
      println(obst.highscore);
      println("THAT WAS");
      if (obst.highscore <= 3) {
        println("PATHETIC");
        println("YOU'RE A ");
        println("WIMP!!!");
      }
      if (obst.highscore > 3 && obst.highscore <= 7) {
        println("UNACCEPTABLE");
        println("YOU'RE A");
        println("NOOB!!!");
      }
      if (obst.highscore > 7 && obst.highscore <= 11) {
        println("ALRIGHT");
        println("YOU'RE A");
        println("GOOD STUDENT!!!");
      }
      if (obst.highscore > 11) {
        println("AMAZING");
        println("YOU'RE A");
        println("PRO!!!");
      }
    }
  }
}