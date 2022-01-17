Bird bird;
Obstacle obst;
BackGround back;
void setup() {
  size(700, 450);
  ellipseMode(CENTER);
  frameRate(40);
  rectMode(CENTER);
  bird = new Bird();
  obst = new Obstacle();
  back = new BackGround();
}
void draw() {
  background(#00deff);
  back.display();
  obst.display();
  bird.display();
}
void keyReleased() {
  bird.change = -6;
}
class Bird {
  float y = 100;
  float change = -8;
  int deaths = 0;
  float wings;
  boolean messages = true;
  void display() {
    wings = 2*change;
    fill(0, 255, 255);
    ellipse(250, y, 60, 60);
    if (wings > 10) {
      wings = 10;
    }
    triangle(240, y+5, 260, y+5, 250, y-wings+5);
    fill(#ffa500);
    triangle(275, y+15, 275, y-15, 290, y+5);
    fill(0);
    ellipse(265, y-7, 5, 5);
    y += change;
    change += 0.75;
    if (y >= height || y <= 0) {
      reset();
    }
    if (obst.range == true && (y <= (obst.oy - 30) || y >= (obst.oy + 30))) {
      reset();
      obst.x = 700;
      obst.oy = int(random(60, 390));
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
      if (messages == true) {
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
}
class Obstacle {
  int x = 750;
  int oy = int(random(60, 390));
  int passes = 0;
  int highscore = 0;
  boolean range = false;
  float speed = 4;
  void display() {
    fill(#00ce00);
    rect(x, (oy-60)/2, 80, oy-60);
    rect(x, height-((height-(oy+60))/2), 80, height-(oy+60));
    speed = 7+(-4/(passes+1));
    x -= speed;
    if (x <= 0) {
      x = 750;
      oy = int(random(60, 390));
      passes ++;
    }
    if (passes > highscore) {
      highscore = passes;
    }
    if (x >= 220 && x <= 280) {
      range = true;
    } else {
      range = false;
    }
  }
}
class BackGround {
  float move = 0;
  void display() {
    fill(#0ed145);
    ellipse(350, height, width*2, 3*height/4);
    fill(#ffff4d);
    ellipse(350+(200*(sin(move))), 100, 70, 70);
    move += 0.0001;
  }
}