ArrayList<Debris> debrisList;
Spaceship ship;

void setup(){
  size(800,450);
  background(245,245,245);
  
  debrisList = new ArrayList<Debris>();
  ship = new Spaceship();
}

void draw(){
  background(245,245,245);
  
  ship.drawShip();
  ship.drawLasers();
  ship.checkHit(debrisList);
  ship.cleanupLasers();
  cleanupDebris();
  
  if(random(1) < 0.01){
    debrisList.add(new Debris());
  }
  
  for(int i = 0; i < debrisList.size(); i++){
    debrisList.get(i).update();
    debrisList.get(i).drawDebris();
  }   
}

void cleanupDebris(){
  for(int i = 0; i < debrisList.size(); i++){
    if(debrisList.get(i).posY - debrisList.get(i).radius > height){
      debrisList.remove(i);
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
