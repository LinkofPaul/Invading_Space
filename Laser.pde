class Laser{ 
  int posX, posY;
  int lenLaser;
  int velY;
  
  Laser(int posX, int posY){
    lenLaser = 20;
    this.posX = posX;
    this.posY = posY;
    velY = -6;    
  } 
  
  void update(){ 
    posY += velY;
  } 
  
  void drawLaser(){
    stroke(0,255,0);
    strokeWeight(5);
    line(posX, posY, posX, posY-lenLaser);
  }
};
