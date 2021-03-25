class Particle{ 
  float posX, posY;
  float velX, velY;
  int radius;
  color colour;
  int lifespan;
  float gravity;
  
  Particle(int posX, int posY, color colour){
    this.posX = posX;
    this.posY = posY;
    this.colour = colour;
    radius = 5;
    lifespan = 200;
    gravity = 0.15;
    velX = randomGaussian()*2;
    velY = randomGaussian()*2;
  } 
  
  void update(){
    velY += gravity;
    velX += random(-gravity,gravity)*2;
    posY += velY;
    posX += velX;
    if(lifespan < 0){
      velX = 0;
      velY = 0;
      gravity = 0;
    }else{
      lifespan -= 10;
    }
  } 
  
  void drawParticle(){
    fill(colour);
    strokeWeight(0);
    stroke(0);
    ellipse(posX, posY, radius, radius);
  }
}; 
