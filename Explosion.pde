class Explosion{ 
  ArrayList<Particle> particles;
  
  Explosion(int posX, int posY, color colour){
    particles = new ArrayList<Particle>();
    for(int i=0; i < 100; i++){
      particles.add(new Particle(posX, posY, colour));
    }
  } 

};
