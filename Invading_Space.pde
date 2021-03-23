ArrayList<Debris> debrisList;
ArrayList<Explosion> explosions;
Spaceship ship;
color bg_color;

void setup(){
  size(800,450);
  bg_color = color(245,245,245);
  background(bg_color);
  
  debrisList = new ArrayList<Debris>();
  explosions = new ArrayList<Explosion>();
  ship = new Spaceship();
}

void draw(){
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

void keyPressed() {
  if(key == 'a' || keyCode == LEFT){
    ship.moveLeft();
  }else if(key == 'd' || keyCode == RIGHT){
    ship.moveRight();
  }
  
  if(key == ENTER || key == ' '){
    ship.shoot();
  }
}
