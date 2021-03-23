ArrayList<Debris> debrisList;
ArrayList<Explosion> explosions;
Spaceship ship;
color bg_color;

boolean start;
boolean playmode;
boolean freemode;
boolean playing;
boolean gameover;

int player_lives;
float startTime;
float finishTime;
PImage heart1;
PImage heart2;
PImage heart3;

void setup(){
  size(800,450);
  bg_color = color(245,245,245);
  
  start = true;
  playmode = false;
  freemode = false;
  playing = false;
  gameover = false;
  
  player_lives = 3;
  finishTime = 0;
  heart1 = loadImage("heart.png");
  heart2 = loadImage("heart.png");
  heart3 = loadImage("heart.png");
  
  debrisList = new ArrayList<Debris>();
  explosions = new ArrayList<Explosion>();
  ship = new Spaceship();
}

void draw(){
  if(start){
    drawStartMenu();
  }else if(gameover){
    drawGameoverMenu();
  }else if(playmode){
    startPlaymode();
  }else if(freemode){
    startFreemode();
  }
}


void drawStartMenu(){
  background(bg_color);
  ship.drawShip();
  fill(225);
  strokeWeight(5);
  stroke(0);
  rect(300, 150, 200, 50); 
  rect(300, 250, 200, 50);
  
  textSize(32);
  fill(0,0,0);
  text("PlayMode", 330, 185);
  text("FreeMode", 330, 285);
  
  textSize(56);
  fill(0,0,0);
  text("Invading Space", 200, 85);
}

void drawGameoverMenu(){ 
  fill(225);
  strokeWeight(5);
  stroke(0);
  rect(300, 150, 200, 50); 
  rect(300, 250, 200, 50);
  
  textSize(32);
  fill(0,0,0);
  text("PlayMode", 330, 185);
  text("FreeMode", 330, 285);
  
  textSize(56);
  fill(0,0,0);
  text("Game Over", 250, 85);
  if(finishTime > 0){
    textSize(32);
    fill(250,0,60);
    text(nf(finishTime, 0, 1), 20, 40);
  }
}

void startPlaymode(){
  background(bg_color);
  for(int i = 0; i < explosions.size(); i++){
    for(int n = 0; n < explosions.get(i).particles.size(); n++){
      explosions.get(i).particles.get(n).update();
      explosions.get(i).particles.get(n).drawParticle();
    }
  }
  
  ship.drawShip();
  ship.drawLasers();
  checkHit(ship.lasers);
  
  cleanupLasersAndchangeBG(ship.lasers);
  
  if(random(1) < 0.01){
    debrisList.add(new Debris());
  } 
  
  for(int i = 0; i < debrisList.size(); i++){
    debrisList.get(i).update();
    debrisList.get(i).drawDebris();
  } 
  
  updateLives();
  updateTime();
}

void startFreemode(){
  background(bg_color);
  for(int i = 0; i < explosions.size(); i++){
    for(int n = 0; n < explosions.get(i).particles.size(); n++){
      explosions.get(i).particles.get(n).update();
      explosions.get(i).particles.get(n).drawParticle();
    }
  }
  
  ship.drawShip();
  ship.drawLasers();
  checkHit(ship.lasers);
  
  cleanupLasersAndchangeBG(ship.lasers);
  cleanupDebris();
  
  if(random(1) < 0.01){
    debrisList.add(new Debris());
  } 
  
  for(int i = 0; i < debrisList.size(); i++){
    debrisList.get(i).update();
    debrisList.get(i).drawDebris();
  } 
}

void updateLives(){
  switch(player_lives){
    case 3:
      image(heart1, 640, 20, 40, 40);
      image(heart2, 690, 20, 40, 40);
      image(heart3, 740, 20, 40, 40);
      break;
    case 2:
      image(heart1, 640, 20, 40, 40);
      image(heart2, 690, 20, 40, 40);
      break;
    case 1:
      image(heart1, 640, 20, 40, 40);
      break;
    default:
      gameover();
      break;
  }
  
  for(int i = 0; i < debrisList.size(); i++){
    if(debrisList.get(i).posY + debrisList.get(i).radius/2 >= height){
      debrisList.remove(i);
      player_lives -= 1;
    }
  }
}

void updateTime(){
  float runningTime = (millis() - startTime)/1000;
  textSize(32);
  fill(250,0,60);
  text(nf(runningTime, 0, 1), 20, 40);
}

void gameover(){
  if(playmode) finishTime = (millis() - startTime)/1000;
  
  takingScreenshot();
  
  gameover = true;
  playing = false;
  playmode = false;
  freemode = false;
    
  ship = null;
  debrisList.clear();
  explosions.clear();
  ship = new Spaceship();
}

void takingScreenshot(){
  background(bg_color);
  for(int i = 0; i < explosions.size(); i++){
    for(int n = 0; n < explosions.get(i).particles.size(); n++){
      explosions.get(i).particles.get(n).update();
      explosions.get(i).particles.get(n).drawParticle();
    }
  }
  
  if(finishTime > 0){
    saveFrame("./screenshots/screenshot-" + finishTime + "######.png");
  }else{
    saveFrame("./screenshots/screenshot-######.png");
  }
  
  
  ship.drawShip();
  ship.drawLasers();
  
  for(int i = 0; i < debrisList.size(); i++){
    debrisList.get(i).update();
    debrisList.get(i).drawDebris();
  } 
}

void checkHit(ArrayList<Laser> lasers){
  for(int x=0; x < debrisList.size(); x++){
    for(int y=0; y < lasers.size(); y++){
      if(lasers.get(y).posY - lasers.get(y).lenLaser < debrisList.get(x).posY + debrisList.get(x).radius
         && lasers.get(y).posX > debrisList.get(x).posX - debrisList.get(x).radius
         && lasers.get(y).posX < debrisList.get(x).posX + debrisList.get(x).radius){
        
        explosions.add(new Explosion(debrisList.get(x).posX, debrisList.get(x).posY, debrisList.get(x).colour));
        debrisList.remove(x);
        lasers.remove(y);
        break;
          
      }
    }
  }
}
  
void cleanupDebris(){
  for(int i = 0; i < debrisList.size(); i++){
    if(debrisList.get(i).posY - debrisList.get(i).radius > height){
      debrisList.remove(i);
    }
  }
}

void cleanupLasersAndchangeBG(ArrayList<Laser> lasers){
  for(int i = 0; i < lasers.size(); i++){
    if(lasers.get(i).posY < 0){         
      lasers.remove(i);
      
      bg_color = color((int) random(0,255), (int) random(0,255), (int) random(0,255));
    }
  } 
}

void mousePressed(){
  if(mouseX > 300 && mouseX < 500 && mouseY > 150 && mouseY < 200 && !playmode){
    start = false;
    gameover = false;
    playmode = true;
    freemode = false;
    playing = true;
    player_lives = 3;
    startTime = millis();
    finishTime = 0;
    bg_color = color(245,245,245);
  }else if(mouseX > 300 && mouseX < 500 && mouseY > 250 && mouseY < 300 && !freemode){
    start = false;
    gameover = false;
    playmode = false;
    freemode = true;
    playing = true;
    finishTime = 0;
    bg_color = color(245,245,245);
  }
}

void keyPressed() {
  if((key == 'a' || keyCode == LEFT) && playing){
    ship.moveLeft();
  }else if((key == 'd' || keyCode == RIGHT) && playing){
    ship.moveRight();
  }
  
  if((key == ENTER || key == ' ') && playing){
    ship.shoot();
  }
  
  if(key == ESC && playing){
    key = 0;
    gameover();
  }
}
