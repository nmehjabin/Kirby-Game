int kirby_s = 30;
class Kirby {
  PVector location;
  PVector velocity ;
  PVector acc;
  float x_step = 3.8;

  // this boolean controls if ball can jump or not
  //by default ball can jump
  boolean can_jump = true;
  PImage img;
  float img_w;
  float img_h;

  Kirby(float x, float y, String imageFileName) {
    this.location =new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.acc = new PVector(0, 0.5);
    this.img = loadImage(imageFileName);
    this.img_w = 40;
    this.img_h = 40;
  }

  void moveRight () {
    this.velocity.x = 3;
  }

  void moveLeft () {
    this.velocity.x = -3;
  }

  void update() {
    this.location.add(this.velocity);
    
    // using the accleration  attribute of the 
    // ball object at this moment, update the velocity PVector 
    this.velocity.add(this.acc);
  }

  // this function checks if THE kirby (i.e the kirby object that calls this function)
  // can stand on a log. It returns true if it can, otherwise it will return false!
  boolean canStand(Platform p) {
    if ((this.location.x > p.location.x && this.location.x < p.location.x + p.img_w/2 &&
    this.location.y > p.location.y - 20 &&this.location.y < p.location.y)) {
      return true;
    } else {
      return false;
    }
  }
}
