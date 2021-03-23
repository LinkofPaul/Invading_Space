class Spaceship{ 
  ArrayList<Laser> lasers;
  int centerX, centerY;
  int radius;
  int velX;
  
  Spaceship(){  
    lasers = new ArrayList<Laser>();
    radius = 15;
    velX = 20;
    centerX = width/2;
    centerY = 400;
  } 
  
  void moveLeft(){
    if(centerX > radius*2){
      centerX -= velX;  
    }
  }
  
  void moveRight(){
    if(centerX < width-radius*2){
      centerX += velX;
    }
  }
  
  void shoot(){
    lasers.add(new Laser(centerX, centerY-radius));
  }
  
  void checkHit(ArrayList<Debris> debrisList){
    for(int x=0; x < debrisList.size(); x++){
      for(int y=0; y < lasers.size(); y++){
        if(lasers.get(y).posY - lasers.get(y).lenLaser < debrisList.get(x).posY + debrisList.get(x).radius
           && lasers.get(y).posX > debrisList.get(x).posX - debrisList.get(x).radius
           && lasers.get(y).posX < debrisList.get(x).posX + debrisList.get(x).radius){
          debrisList.remove(x);
          lasers.remove(y);
          break;
          
        }
      }
    }
  }
  
  void drawShip(){
    fill(0,0,255);
    strokeWeight(2);
    stroke(0);
    triangle(centerX-radius, centerY+radius, centerX, centerY-radius, centerX+radius, centerY+radius);
  }
  
  void drawLasers(){
    for(int i = 0; i < lasers.size(); i++){
      lasers.get(i).update();
      lasers.get(i).drawLaser();
    } 
  }
  
  void cleanupLasers(){
    for(int i = 0; i < lasers.size(); i++){
      if(lasers.get(i).posY < 0){
        lasers.remove(i);
      }
    } 
  }
}; 
