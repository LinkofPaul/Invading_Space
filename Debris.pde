class Debris{ 
  int posX, posY;
  int radius;
  int velY;
  
  Debris(){
    radius = 40;
    posX = (int) random(radius,  width-radius);
    posY = (int) -radius;
    velY = 1;    
  } 
  
  void update(){ 
    posY += velY;
  } 
  
  void drawDebris(){
    fill(255,0,0);
    strokeWeight(4);
    stroke(0);
    ellipse(posX, posY, radius, radius);
  }
}; 
