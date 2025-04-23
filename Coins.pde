class Coins {
  PVector location;
  float img_w;
  float img_h ;
  float radius;
  boolean isAlive = true;

  Coins(float x, float y, float w, float h) {
    this.location =new PVector(x, y);
    this.img_w =w;
    this. img_h =h;
    this.radius= 1 ;
  }
 
  void showCoins() {

    if (isAlive) {
      if (frameCount % 500 == 0) {
        tint(255, 128);
      } else {
        noTint();
      }
      image(coinsImg, this.location.x, this.location.y, this.img_w, this.img_h );
    }
  }

  void gettingCoins() {
    this.isAlive = false;
  }

//checks the collusion with ball object
  boolean checkCollision (Kirby b) {
    if (dist(b.location.x, b.location.y, this.location.x+ this.img_w/2, this.location.y+ this.img_h/2) < kirby_s + this.radius ) {
      return true;
    } else {
      return false;
    }
  }
}
