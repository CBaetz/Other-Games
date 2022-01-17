Snake snake;
Food food;
void setup() {
  size(1000, 600);
  rectMode(CENTER);
  frameRate(14);
  snake = new Snake();
  food = new Food();
  food.reset();
}

void draw() {
  background(0, 100, 200);
  if (dist(snake.x.get(0), snake.y.get(0), food.x, food.y)<snake.sidelen) { 
    snake.addlink();
    food.reset();
  }
  food.display();
  snake.move();
  snake.display();
}
void keyPressed() {
  if (key == 'w' || key == 'W' || keyCode == UP && snake.dir != "down") {
    snake.dir = "up";
  }
  if (key == 's' || key == 'S' || keyCode == DOWN && snake.dir != "up") {
    snake.dir = "down";
  }  
  if (key == 'd' || key == 'D' || keyCode == RIGHT && snake.dir != "left") {
    snake.dir = "right";
  }
  if (key == 'a' || key == 'A' || keyCode == LEFT && snake.dir != "right") {
    snake.dir = "left";
  }
}

