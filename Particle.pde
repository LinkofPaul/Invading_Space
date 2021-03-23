class Particle{ 
  int posX, posY;
  int velX, velY;
  int radius;
  color colour;
  int lifespan;
  
  Particle(int posX, int posY, color colour){
    this.posX = posX;
    this.posY = posY;
    this.colour = colour;
    radius = 5;
    lifespan = 100;
    velX = (int) random(-5,5);
    velY = (int) random(-5,5);
  } 
  
  void update(){ 
    posY += velY;
    posX += velX;
    if(lifespan < 0){
      velX = 0;
      velY = 0;
    }else{
      lifespan -= 5;
    }
  } 
  
  void drawParticle(){
    fill(colour);
    strokeWeight(0);
    stroke(0);
    ellipse(posX, posY, radius, radius);
  }
}; 
