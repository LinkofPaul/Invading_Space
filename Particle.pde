class Particle{ 
  float posX, posY;
  float velX, velY;
  int radius;
  color colour;
  int particleDuration;
  float gravity;
  
  Particle(int posX, int posY, color colour){
    this.posX = posX;
    this.posY = posY;
    this.colour = colour;
    radius = 5;
    particleDuration = 200;
    gravity = 0.15;
    // use normal distribution to have more particles towards the center than outwards
    velX = randomGaussian()*2;
    velY = randomGaussian()*2;
  } 
  
  void update(){
    // apply small amount of gravity and also to x-Velocity to move faster to the sides
    velY += gravity;
    velX += random(-gravity,gravity)*2;
    posY += velY;
    posX += velX;
    // stop the particles after particleDuration hits zero
    if(particleDuration < 0){
      velX = 0;
      velY = 0;
      gravity = 0;
    }else{
      particleDuration -= 10;
    }
  } 
  
  void drawParticle(){
    fill(colour);
    strokeWeight(0);
    stroke(0);
    ellipse(posX, posY, radius, radius);
  }
}; 
