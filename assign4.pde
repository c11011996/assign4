int fighterX, fighterY, fighterW, fighterH;
int bgX, hp1;
int treasureX, treasureY, treasureW, treasureH;
int enemyX, enemyY, enemyW, enemyH;
PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2, flame1, flame2, flame3, flame4, flame5;
PImage [] flames = new PImage [5];
final int GAME_START = 0, GAME_RUN = 1, GAME_WIN = 2, GAME_OVER = 3;
final int STRAIGHT = 0, TILT = 1, DIAMOND = 2;
boolean [] shoot = new boolean [8];
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
  flame1 = loadImage("img/flame1.png");
  flame2 = loadImage("img/flame2.png");
  flame3 = loadImage("img/flame3.png");
  flame4 = loadImage("img/flame4.png");
  flame5 = loadImage("img/flame5.png");

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
  for(int i=0; i<5; i++){
    flames[i] = loadImage("img/flame"+(i+1)+".png");
  }
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
          //as a trigger of the enemy
          for(int i=0; i<5; i++){
          shoot[i] = true;
        }
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
             int [] enemyXY = new int [5];
             enemyXY[i] = i;
             if(shoot[i]){
             //hit detection   
             if(fighterX+fighterH >= enemyX-enemyXY[i]*enemyW && fighterX <= enemyX-enemyXY[i]*enemyW+enemyW){
             if(fighterY+fighterH >= enemyY && fighterY <= enemyY+enemyH){
                 shoot[i] = false;  
                 hp1-=38;
                 //println (hp1) ;
                 image(flames[i],enemyX-enemyXY[i]*enemyW,enemyY);
                 }
               }
             }
             if(shoot[i]==true){
             image(enemy,enemyX-enemyXY[i]*enemyW,enemyY);
             } 
           }
           enemyX += 5;
           if(enemyX-enemyW*4 > width){
             enemyState = TILT;
             enemyX=0;
             enemyY = floor(random(50, 180));
             for(int i=0; i<5; i++){
               shoot[i] = true;
             }
           }
       break;
       
    case TILT:
      for (int i=0; i<5; i++){
        int [] enemyXY = new int [5];
        enemyXY[i] = i;
        //hit detection         
        if(shoot[i]){  
             if(fighterX+fighterH >= enemyX-enemyXY[i]*enemyW && fighterX <= enemyX+(1-enemyXY[i])*enemyW){
             if(fighterY+fighterH >= enemyY+enemyXY[i]*enemyH && fighterY <= enemyY+(1+enemyXY[i])*enemyH){
                 shoot[i] = false;  
                 hp1-=38;
                 //println (hp1) ;
                 image(flames[i],enemyX-enemyXY[i]*enemyW,enemyY);
                 }
               }
             }
             if(shoot[i]==true){
               image(enemy, enemyX-enemyXY[i]*enemyW, enemyY+enemyXY[i]*enemyH);   
             }
         }
         enemyX+=5;
          if (enemyX-4*enemyW > width){
          enemyState = DIAMOND;
          enemyX=0;
          enemyY = floor(random(50, 200));
          for(int i=0; i<5; i++){
            shoot[i] = true;
           } 
          }
         
      break; 
        
    case DIAMOND:
        for(int i=0; i<3; i++){
          int [] enemyXY = new int [8];
          enemyXY[i] = i*60-170;
          //hit detection         
          if(shoot[i]){  
              if(enemyY+enemyXY[i]+170+60>=fighterY && fighterY>=enemyY+enemyXY[i]+170-50){
              if(enemyX+enemyXY[i]-30-50<=fighterX && fighterX<=enemyX+enemyXY[i]-30+60){
                   shoot[i] = false;  
                   hp1-=38;
                   println (hp1);
                   image(flames[i],enemyX+enemyXY[i]-30, enemyY+enemyXY[i]+170);
                   }
                 }
               }
          if(shoot[i]==true){
          image(enemy, enemyX+enemyXY[i]-30, enemyY+enemyXY[i]+170);
          }
        }
        for(int i=3; i<6; i++){
          int [] enemyXY = new int [8];
          enemyXY[i] = (i-3)*60-170;
          //hit detection         
          if(shoot[i]){  
             if(enemyY+enemyXY[i]+290+60>=fighterY && fighterY>=enemyY+enemyXY[i]+290-50){
             if(enemyX+enemyXY[i]-120-30-50<=fighterX && fighterX<=enemyX+enemyXY[i]-120-30+60){
                   shoot[i] = false;  
                   hp1-=38;
                   println (hp1) ;
                   image(flames[i],enemyX+enemyXY[i]-120-30, enemyY+enemyXY[i]+290);
                   }
                 }
               }
          if(shoot[i]==true){
          image(enemy, enemyX+enemyXY[i]-120-30, enemyY+enemyXY[i]+290);
          }
        }
        for(int i=6; i<8; i++){
          int [] enemyXY = new int [8];
          enemyXY[i] = (i-6)*120-170;
          //hit detection         
          if(shoot[i]){  
            if(enemyY+enemyXY[i]+230+60>=fighterY && fighterY>=enemyY+enemyXY[i]+230-50){
            if(enemyX+enemyXY[i]-60-30-50<=fighterX && fighterX<=enemyX+enemyXY[i]-60-30+60){
                   shoot[i] = false;  
                   hp1-=38;
                   println (hp1) ;
                   image(flames[i],enemyX+enemyXY[i]-60-30, enemyY+enemyXY[i]+230);
                   }
                 }
               }
          if(shoot[i]==true){
          image(enemy, enemyX+enemyXY[i]-60-30, enemyY+enemyXY[i]+230);
          }
        }
        enemyX+=5;
        if (enemyX-enemyW*5 > width) {
          enemyState = STRAIGHT;
          enemyX=0;
          enemyY = floor(random(50, 360));
          for(int i=0; i<5; i++){
               shoot[i] = true;
             }
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
              
     if(fighterX+fighterW >= treasureX && fighterX <= treasureX+treasureW+fighterW){
       if(fighterY >= treasureY-fighterH && fighterY <= treasureY+fighterH){
       hp1 += 19;
       println(hp1);
       treasureX = floor(random(600));
       treasureY = floor(random(440));
       }
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
        enemyState = STRAIGHT;
        enemyX=0;
        enemyY = floor(random(50, 360));
        for(int i=0; i<5; i++){
         shoot[i] = true;
        }
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
