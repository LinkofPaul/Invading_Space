import processing.sound.*;

ArrayList<Debris> debrisList;
ArrayList<Explosion> explosions;
Spaceship ship;
color bg_color;

SoundFile menu_music;
SoundFile background_music;
SoundFile shoot_sound;
SoundFile explosion_sound;
SoundFile gameover_music;

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
  
  background_music = new SoundFile(this, "background_music.wav");
  background_music.amp(0.25);
  shoot_sound = new SoundFile(this, "shot.wav");
  shoot_sound.amp(0.25);
  explosion_sound = new SoundFile(this, "explosion_sound.wav");
  explosion_sound.amp(1);
  gameover_music = new SoundFile(this, "gameover_sound.wav");
  gameover_music.amp(0.75);
  menu_music = new SoundFile(this, "menu_music.wav");
  menu_music.amp(0.15);
  menu_music.loop();
  
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

void drawMenu(){
  strokeWeight(5);
  stroke(0);
  fill(225);
  rect(300, 150, 200, 50); 
  rect(300, 250, 200, 50);
  
  if(mouseX > 300 && mouseX < 500 && mouseY > 150 && mouseY < 200){
    cursor(HAND);
    fill(255);
    rect(300, 150, 200, 50);    
  }
  
  if(mouseX > 300 && mouseX < 500 && mouseY > 250 && mouseY < 300){
    cursor(HAND);
    fill(255);
    rect(300, 250, 200, 50);
  }
  
  if(!(mouseX > 300 && mouseX < 500 && mouseY > 150 && mouseY < 200) 
     && !(mouseX > 300 && mouseX < 500 && mouseY > 250 && mouseY < 300)) cursor(ARROW);
  
  textSize(32);
  fill(0,0,0);
  text("PlayMode", 330, 185);
  text("FreeMode", 330, 285);
}

void drawStartMenu(){
  background(bg_color);
  ship.drawShip();
  drawMenu();
  
  textSize(56);
  fill(0,0,0);
  text("Invading Space", 200, 85);
}

void drawGameoverMenu(){ 
  drawMenu();
  
  textSize(56);
  fill(0,0,0);
  text("Game Over", 250, 85);
  if(finishTime > 0){
    textSize(32);
    fill(250,0,60);
    text(nf(finishTime, 0, 1), 20, 40);
  }
}

void drawGame(){
  background(bg_color);
  for(int i = 0; i < explosions.size(); i++){
    for(int n = 0; n < explosions.get(i).particles.size(); n++){
      explosions.get(i).particles.get(n).update();
      explosions.get(i).particles.get(n).drawParticle();
    }
  }
  
  ship.drawShip();
  ship.drawLasers();
  cleanupLasersAndChangeBackground(ship.lasers);
  checkHit(ship.lasers);
  
  if(random(1) < 0.01){
    debrisList.add(new Debris());
  } 
  
  for(int i = 0; i < debrisList.size(); i++){
    debrisList.get(i).update();
    debrisList.get(i).drawDebris();
  }
}

void startPlaymode(){
  drawGame();
  
  updateLives();
  updateTime();
}

void startFreemode(){
  drawGame();
  
  drawAndCheckExitButton();
  cleanupDebris();
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
    if(debrisList.get(i).posY + debrisList.get(i).radius/3 >= height
       || debrisList.get(i).posY + debrisList.get(i).radius/3 >= ship.centerY - ship.radius
          && debrisList.get(i).posX >= ship.centerX - ship.radius && debrisList.get(i).posX <= ship.centerX + ship.radius
       || debrisList.get(i).posY + debrisList.get(i).radius/5 >= ship.centerY - ship.radius
          && debrisList.get(i).posX >= ship.centerX - ship.radius*2 && debrisList.get(i).posX <= ship.centerX + ship.radius*2){
      debrisList.remove(i);
      player_lives -= 1;
      explosion_sound.play();
    }
  }
}

void updateTime(){
  float runningTime = (millis() - startTime)/1000;
  textSize(32);
  fill(250,0,60);
  text(nf(runningTime, 0, 1), 20, 40);
}

void drawAndCheckExitButton(){
  textSize(56);
  fill(250,0,60);
  text("X", 740, 60);
  
  if(mouseX > 730 && mouseX < 785 && mouseY > 10 && mouseY < 70){
    cursor(HAND);
  }else{
    cursor(ARROW);
  }
}

void gameover(){
  if(playmode) finishTime = (millis() - startTime)/1000;
  
  takingScreenshot();
  
  gameover = true;
  playing = false;
  playmode = false;
  freemode = false;
   
  background_music.stop();
  gameover_music.play();
  
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
    saveFrame("./screenshots/screenshot_playmode-" + finishTime + ".png");
  }else{
    saveFrame("./screenshots/screenshot_freemode-" + "####.png");
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
      if(lasers.get(y).posY - lasers.get(y).lenLaser < debrisList.get(x).posY + debrisList.get(x).radius/2
         && lasers.get(y).posX > debrisList.get(x).posX - debrisList.get(x).radius
         && lasers.get(y).posX < debrisList.get(x).posX + debrisList.get(x).radius){
        
        explosion_sound.play();
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

void cleanupLasersAndChangeBackground(ArrayList<Laser> lasers){
  for(int i = 0; i < lasers.size(); i++){
    if(lasers.get(i).posY < 0){         
      lasers.remove(i);
      
      bg_color = color((int) random(0,255), (int) random(0,255), (int) random(0,255));
    }
  } 
}

void startMode(boolean isPlayMode){
    start = false;
    gameover = false;
    playing = true; 
    playmode = isPlayMode;
    freemode = !isPlayMode;
    cursor(ARROW);
    finishTime = 0;
    bg_color = color(245,245,245);
    menu_music.stop();
    background_music.loop();
}

void mousePressed(){
  if(mouseX > 300 && mouseX < 500 && mouseY > 150 && mouseY < 200 && !playmode){
    startMode(true);
    player_lives = 3;
    startTime = millis();
  }else if(mouseX > 300 && mouseX < 500 && mouseY > 250 && mouseY < 300 && !freemode){
    startMode(false);   
  }else if(mouseX > 730 && mouseX < 785 && mouseY > 10 && mouseY < 70 && freemode){
    gameover();
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
    shoot_sound.play();
  }
  
  if(key == ESC && playing){
    key = 0;
    gameover();
  }
}
