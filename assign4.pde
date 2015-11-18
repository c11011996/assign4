int fighterX, fighterY, fighterW, fighterH;
int bgX;
int hp1;
int treasureX, treasureY, treasureW, treasureH;
int enemyX, enemyY, enemyW, enemyH;
PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2;
final int GAME_START = 0, GAME_RUN = 1, GAME_WIN = 2, GAME_OVER = 3;
final int STRAIGHT = 0, TILT = 1, DIAMOND = 2;
int [] straightX = new int[5];
int [] straightY = new int[5];
int [] tiltX = new int[5];
int [] tiltY = new int[5];
int [] diamondX1 = new int[3];
int [] diamondY1 = new int[3];
int [] diamondX2 = new int[3];
int [] diamondY2 = new int[3];
int gameState, enemyState;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup () {
  size(640, 480) ;
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");

  gameState = GAME_START; 
  enemyState = STRAIGHT;
  fighterW = 50;
  fighterH = 50;
  fighterX = 590;
  fighterY = 240;
  bgX = 0;
  hp1 = 190;
  enemyW = 60;
  enemyH = 60;
  enemyX = 0;
  enemyY = floor(random(50, 240));
  treasureW = 40;
  treasureH = 40;
  treasureX = floor(random(10,600));
  treasureY = floor(random(30, 440));
}


void draw() {

  switch(gameState) {
    //GAME START
  case GAME_START:
    image(start2, 0, 0);
    if (mouseY > 365 && mouseY < 420 && mouseX > 200 && mouseX < 408) {
      image(start1, 0, 0);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    }
    break;

    //GAME RUN
  case GAME_RUN:
    //background
    image(bg1, bgX, 0);
    bgX++;
    image(bg2, bgX-640, 0);
    image(bg1, bgX-1280, 0);
    bgX%=1280;
    image(treasure, treasureX, treasureY);
    //hp
    fill(255, 0, 0, 240);
    rect(18, 10, hp1, 14);    
    image(hp, 5, 1);
    //enemy
    switch(enemyState) {
       case STRAIGHT:
       for(int i=0;i<5;i++){
         straightX[i] = enemyX-i*enemyW;
         straightY[i] = enemyY;
         image(enemy,straightX[i],straightY[i]);
         //hit detection   
         if(fighterX+fighterH >= straightX[i] && fighterX <= straightX[i]+enemyW){
         if(fighterY+fighterH >= straightY[i] && fighterY <= straightY[i]+enemyH){
             hp1-=38;
             println (hp1) ;
             straightX[i] =-10;
           straightY[i] = -10;}
           }
         }
       enemyX += 5;
       if(enemyX-enemyW*4 > width){
         enemyState = TILT;
         enemyX=0;
         enemyY = floor(random(50, 180)); 
       }
       break;
       
    case TILT:
      for (int j=0; j<5; j++){
        tiltX[j] = enemyX-j*enemyW;
        tiltY[j] = enemyY+j*enemyH;
        image(enemy, tiltX[j], tiltY[j]); 
      }
        enemyX+=5;
          if (enemyX-4*enemyW > width){
          enemyState = DIAMOND;
          enemyX=0;
          enemyY = floor(random(150, 300)); 
          }
         
      break; 
        
    case DIAMOND:
      for(int k=0; k<3; k++){
        diamondX1 [k] = enemyX-k*enemyW;
        diamondX2 [k] = enemyX-(4-k)*enemyW;
        diamondY1 [k] = enemyY-k*enemyH;
        diamondY2 [k] = enemyY+k*enemyH;
        image(enemy, diamondX1[k], diamondY1[k]);
        image(enemy, diamondX1[k], diamondY2[k]);
        image(enemy, diamondX2[k], diamondY1[k]);
        image(enemy, diamondX2[k], diamondY2[k]); 
    }
      enemyX+=5;
      if (enemyX-enemyW*4 > width) {
        enemyState = STRAIGHT;
        enemyX=0;
        enemyY = floor(random(50, 360)); 
      }
        
      break;
    }
    //fighter
    image(fighter, fighterX, fighterY);
    if (upPressed) {
      fighterY -= 5;
      if (fighterY < 0) {
        fighterY = 0;
      }
    }
    if (downPressed) {
      fighterY += 5;
      if (fighterY > 430) {
        fighterY = 430;
      }
    }
    if (leftPressed) {
      fighterX -= 5;
      if (fighterX < 0) {
        fighterX = 0;
      }
    }
    if (rightPressed) {
      fighterX += 5;
      if (fighterX > 590) {
        fighterX = 590;
      }
    }
              
     if(fighterX+fighterW >= treasureX && fighterX <= treasureX+treasureW+fighterW && fighterY >= treasureY-fighterH && fighterY <= treasureY+fighterH){
     hp1 += 19;
     println(hp1);
     treasureX = floor(random(600));
     treasureY = floor(random(440));
     }
     
      if (hp1 <= 0) {gameState=GAME_OVER;}
      if (hp1 >= 190) {hp1 = 190;}
    break;

    //GAME OVER
  case GAME_OVER:
    image(end2, 0, 0);
    if (mouseY > 305 && mouseY < 350 && mouseX > 200 && mouseX < 434) {
      image(end1, 0, 0);
      if (mousePressed) {
        hp1 = 190;
        fighterX = 590;
        fighterY = 240;
        gameState = GAME_RUN;
      }
    }
    break;
  }
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
    case UP:
      upPressed = true;
      break;
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
    }
  }
}
void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}
