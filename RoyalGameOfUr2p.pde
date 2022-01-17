//Defining vars
int turn = 1;
int roll = 0;
int selected = 0;
int doneMoves = 0;
int wStart = 7;
int bStart = 7;
int wDone = 0;
int bDone = 0;
int[] rolls = new int[4];
int[] stones = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int[] ySpace = {4, 3, 2, 1, 1, 2, 3, 4, 5, 6, 7, 8, 8, 7};
int[] xSpace = {1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1};

//Setup
void setup() {
  size(400, 500);
  rectMode(CENTER);
  ellipseMode(CENTER);
  roll();
}

//Drawing
void draw() {
  constantDraw();
  stoneDraw();
  rollDraw();
  if (wDone == 7) {
    println("Congratulations! White Won!");
    exit();
  }
  if (bDone == 7) {
    println("Congratulations! Black Won!");
    exit();
  }
}

//Drawing the roll results
void rollDraw() {
  for (int i = 1; i < 5; i++) {
    stroke(0);
    fill(255*(1-rolls[i-1]));
    ellipse(80*i, 450, 50, 50);
  }
}

//Changing the dice
void roll() {
  roll = 0;
  for (int i = 0; i < 4; i++) {
    rolls[i] = int(random(2));
    roll += rolls[i];
  }
  doneMoves = 0;
}

//Moving the stone
void move() {
  if (roll!=0) {
    //If soft lock
    int possMoves = 0;
    for (int i = 0; i<14; i++) {
      if (i + roll < 14) {
        if ((stones[i] == turn || stones[i] == 3) && (stones[i + roll] == 3-turn || stones[i + roll] == 0) && i + roll != 7) {
          possMoves += pow(2, i);
        }
        if (stones[7] == 0 && i + roll == 8 && (stones[i] == turn || stones[i] == 3)) {
          possMoves += pow(2, i);
        }
      }
    }
    if (turn == 1 && wStart > 0 && (stones[roll - 1] == 2 || stones[roll - 1] == 0)) {
      possMoves ++;
    } else if (turn == 2 && bStart > 0 && (stones[roll - 1] == 1 || stones[roll - 1] == 0)) {
      possMoves ++;
    }
    if (selected > 0 && doneMoves == possMoves) {
      turn = 3-turn;
      roll();
      println("soft lock");
    }//Starting stones
    else if (selected == -1) {
      if (stones[roll-1] == 0 || stones[roll-1] == 3-turn) {
        if (turn==1) {
          wStart--;
        } else {
          bStart--;
        }
        stones[roll-1] += turn;
        if (roll != 4) {
          turn = 3-turn;
        }
        roll();
      } else if (possMoves % 2 == 0) {
        doneMoves++;
      }
    }//Opening moves 
    else if (selected + roll < 5 ) {
      if (stones[selected + roll -1] == 0 || stones[selected + roll -1] == 3-turn) {
        stones[selected-1] -= turn;
        stones[selected + roll -1] += turn;
        if (selected + roll != 4) {
          turn = 3-turn;
        }
        roll();
      } else if (doneMoves % pow(2, selected) - doneMoves % pow(2, selected - 1) == 0) {
        doneMoves += pow(2, selected - 1);
      }
    }//Special square
    else if (selected + roll == 8) {
      if (stones[7] == 0) {
        stones[selected-1]-=turn;
        stones[7] += turn;
        roll();
      } else if (doneMoves % pow(2, selected) - doneMoves % pow(2, selected-1) == 0) {
        doneMoves += pow(2, selected - 1);
      }
    }//Rest of the center row
    else if (selected + roll < 13) {
      if (stones[selected + roll - 1] == 0) {
        stones[selected-1] -= turn;
        stones[selected+roll-1] = turn;
        turn = 3-turn;
        roll();
      } else if (stones[selected+roll-1] != turn) {
        stones[selected-1]-=turn;
        stones[selected+roll-1]=turn;
        if (turn==1) {
          bStart++;
        } else {
          wStart++;
        }
        turn = 3-turn;
        roll();
      } else if (doneMoves % pow(2, selected) - doneMoves % pow(2, selected-1) == 0) {
        doneMoves += pow(2, selected - 1);
      }
    }//Escaping
    else if (selected+roll >14) {
      stones[selected-1]-=turn;
      if (turn==1) {
        wDone++;
      } else {
        bDone++;
      }
      turn = 3-turn;
      roll();
    }//The other special
    else if (selected+roll ==14) {
      if (stones[13]==0 || stones[13] == 3-turn) {
        stones[selected-1] = 0;
        stones[13]+=turn;
        roll();
      } else if (doneMoves % pow(2, selected) - doneMoves % pow(2, selected-1) == 0) {
        doneMoves += pow(2, selected - 1);
      }
    }//The last one 
    else {
      if (stones[12] == 0 || stones[12] == 3-turn) {
        stones[selected-1]-=turn;
        stones[12]+=turn;
        turn = 3-turn;
        roll();
      } else if (doneMoves % pow(2, selected) - doneMoves % pow(2, selected-1) == 0) {
        doneMoves += pow(2, selected - 1);
      }
    }
  }//If no roll 
  else {
    if (selected != 0) {
      turn =3-turn;
      roll();
    }
  }
}

//Doing the turns
void mousePressed() {
  if (turn==1) {
    if (mouseX< 87.5 && mouseX > 37.5) {
      if (wStart >0) {
        selected = -1;
      } else {
        selected = 0;
      }
    } else if (mouseX<175 && mouseX >= 125 && mouseY <= 200 && mouseY >150) {
      if (stones[0]==1 || stones[0] ==3) {
        selected = 1;
      } else {
        selected = 0;
      }
    } else if (mouseX<175 && mouseX >= 125 && mouseY <= 150 && mouseY >100) {
      if (stones[1]==1 || stones[1] ==3) {
        selected = 2;
      } else {
        selected = 0;
      }
    } else if (mouseX<175 && mouseX >= 125 && mouseY <= 100 && mouseY >50) {
      if (stones[2]==1 || stones[2] ==3) {
        selected = 3;
      } else {
        selected = 0;
      }
    } else if (mouseX<175 && mouseX >= 125 && mouseY <= 50 && mouseY >0) {
      if (stones[3]==1 || stones[3] ==3) {
        selected = 4;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 50 && mouseY >0) {
      if (stones[4]==1) {
        selected = 5;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 100 && mouseY >50) {
      if (stones[5]==1) {
        selected = 6;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 150 && mouseY >100) {
      if (stones[6]==1) {
        selected = 7;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 200 && mouseY >150) {
      if (stones[7]==1) {
        selected = 8;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 250 && mouseY >200) {
      if (stones[8]==1) {
        selected = 9;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 300 && mouseY >250) {
      if (stones[9]==1) {
        selected = 10;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 350 && mouseY >300) {
      if (stones[10]==1) {
        selected = 11;
      } else {
        selected = 0;
      }
    } else if (mouseX >= 175 && mouseX < 225 && mouseY <= 400 && mouseY >350) {
      if (stones[11]==1) {
        selected = 12;
      } else {
        selected = 0;
      }
    } else if (mouseX<175 && mouseX >= 125 && mouseY <=400 && mouseY >350) {
      if (stones[12]==1 || stones[12]==3) {
        selected = 13;
      } else {
        selected = 0;
      }
    } else if (mouseX<175 && mouseX >= 125 && mouseY <= 350 && mouseY >300) {
      if (stones[13]==1 || stones[13] ==3) {
        selected = 14;
      } else {
        selected = 0;
      }
    } else {
      selected = 0;
    }
  } else {

    if (mouseX > 312.5 && mouseX < 362.5) {
      if (bStart >0) {
        selected = -1;
      } else {
        selected = 0;
      }
    } else if (mouseX <= 275 && mouseX > 225 && mouseY <= 200 && mouseY >150) {
      if (stones[0]==2 || stones[0] ==3) {
        selected = 1;
      } else {
        selected = 0;
      }
    } else if (mouseX <= 275 && mouseX > 225 && mouseY <= 150 && mouseY >100) {
      if (stones[1]==2 || stones[1] ==3) {
        selected = 2;
      } else {
        selected = 0;
      }
    } else if (mouseX <= 275 && mouseX > 225 && mouseY <= 100 && mouseY >50) {
      if (stones[2]==2 || stones[2] ==3) {
        selected = 3;
      } else {
        selected = 0;
      }
    } else if (mouseX <= 275 && mouseX > 225 && mouseY <= 50 && mouseY >0) {
      if (stones[3]==2 || stones[3] ==3) {
        selected = 4;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 50 && mouseY >0) {
      if (stones[4]==2) {
        selected = 5;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 100 && mouseY >50) {
      if (stones[5]==2) {
        selected = 6;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 150 && mouseY >100) {
      if (stones[6]==2) {
        selected = 7;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 200 && mouseY >150) {
      if (stones[7]==2) {
        selected = 8;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 250 && mouseY >200) {
      if (stones[8]==2) {
        selected = 9;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 300 && mouseY >250) {
      if (stones[9]==2) {
        selected = 10;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 350 && mouseY >300) {
      if (stones[10]==2) {
        selected = 11;
      } else {
        selected = 0;
      }
    } else if (mouseX > 175 && mouseX <= 225 && mouseY <= 400 && mouseY >350) {
      if (stones[11]==2) {
        selected = 12;
      } else {
        selected = 0;
      }
    } else if (mouseX <= 275 && mouseX > 225 && mouseY <=400 && mouseY >350) {
      if (stones[12]==2 || stones[12]==3) {
        selected = 13;
      } else {
        selected = 0;
      }
    } else if (mouseX <= 275 && mouseX > 225 && mouseY <= 350 && mouseY >300) {
      if (stones[13]==2 || stones[13] ==3) {
        selected = 14;
      } else {
        selected = 0;
      }
    } else {
      selected = 0;
    }
  }
  if (selected!=0) {
    move();
  }
}

//Drawing the stones on the board
void stoneDraw() {
  stroke(0);
  for (int i=0; i<14; i++) {
    //White
    if (stones[i]==1) {
      fill(255);
      ellipse(200-xSpace[i]*50, 50*ySpace[i]-25, 50, 50);
    }
    //Black
    if (stones[i]==2) {
      fill(0);
      ellipse(200+xSpace[i]*50, 50*ySpace[i]-25, 50, 50);
    }
    //Mirrored
    if (stones[i]==3) {
      fill(0);
      ellipse(250, 50*ySpace[i]-25, 50, 50);
      fill(255);
      ellipse(150, 50*ySpace[i]-25, 50, 50);
    }
  }
}

//Drawing what is constant and the code that is ugly
void constantDraw() {
  //Shows the turn
  background((turn % 2) * 255, (turn % 2) * 255, (turn % 2) * 255);

  //The board
  stroke(0);
  fill(#888888);
  rect(200, 25, 50, 50);
  rect(200, 75, 50, 50);
  rect(200, 125, 50, 50);
  rect(200, 175, 50, 50);
  rect(200, 225, 50, 50);
  rect(200, 275, 50, 50);
  rect(200, 325, 50, 50);
  rect(200, 375, 50, 50);
  rect(150, 25, 50, 50);
  rect(150, 75, 50, 50);
  rect(150, 125, 50, 50);
  rect(150, 175, 50, 50);
  rect(150, 325, 50, 50);
  rect(150, 375, 50, 50);
  rect(250, 25, 50, 50);
  rect(250, 75, 50, 50);
  rect(250, 125, 50, 50);
  rect(250, 175, 50, 50);
  rect(250, 325, 50, 50);
  rect(250, 375, 50, 50);

  //Highlighting the special squares
  fill(#CC2222, 100);
  stroke(0, 50);
  ellipse(150, 25, 30, 30);
  ellipse(250, 25, 30, 30);
  ellipse(200, 175, 30, 30);
  ellipse(150, 325, 30, 30);
  ellipse(250, 325, 30, 30);

  //The starting stones
  stroke(0);
  fill(255);
  for (int i = 0; i<wStart; i++) {
    ellipse(62.5, 25+i*(350/6), 50, 50);
  }
  stroke(255);
  fill(0);
  for (int i = 0; i<bStart; i++) {
    ellipse(400-62.5, 25+i*(350/6), 50, 50);
  }

  //The finished stones
  for (int i = 0; i<wDone; i++) {
    ellipse(62.5, 375-i*(350/6), 50, 50);
  }
  stroke(0);
  fill(255);
  for (int i = 0; i<bDone; i++) {
    ellipse(400-62.5, 375-i*(350/6), 50, 50);
  }

  //Illuminating the rolls
  noStroke();
  fill(255);
  rect(200, 451, 400, 99);
  stroke(0);
}