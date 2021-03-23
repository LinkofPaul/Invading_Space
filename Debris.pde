class Debris{ 
  int posX, posY;
  int radius;
  int velY;
  color colour;
  
  Debris(){
    radius = 40;
    colour = color((int) random(0,255), (int) random(0,255), (int) random(0,255));
    posX = (int) random(radius,  width-radius);
    posY = (int) -radius;
    velY = 1;    
  } 
  
  void update(){ 
    posY += velY;
  } 
  
  void drawDebris(){
    fill(colour);
    strokeWeight(4);
    stroke(0);
    ellipse(posX, posY, radius, radius);
  }
}; 
