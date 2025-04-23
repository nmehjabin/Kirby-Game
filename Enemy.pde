class Enemy {
  PImage img;
  PVector location;
  String type = "";

  Enemy(float x, float y) {
    this.location = new PVector(x, y);
  }
}

// Bombs do not move around
//enemy 1
class Bomb extends Enemy {
  float img_w;
  float img_h ;

  Bomb (float x, float y, String imageFileName) {
    super(x, y);
    this.type = "bomb";
    this.img = loadImage(imageFileName);
    this.img_w= 15;
    this.img_h = 15;
  }

  void show() {
    noStroke();
    image(this.img, this.location.x, this.location.y, this.img_w, this.img_h);
  }
  
  //checks the collusion of ball with bomb object
  boolean checkCollision(Kirby b) {
    if (dist(b.location.x, b.location.y, this.location.x+ this.img_w/2, this.location.y+ this.img_h/2) < kirby_s + this.img_w) {
      return true;
    } else {
      return false;
    }
  }
}

//enemy 2

class Rocket extends Enemy {

  float xspeed = 1;  // Speed of the shape
  int left_to_right_direction = 1;  // Left or Right
  int right_to_left_direction = -1;
  float img_w ;
  float img_h;

  Rocket (float x, float y, String imageFileName) {
    super(x, y);
    this.type = "rocket";
    this.img = loadImage(imageFileName);
    this.img_w = 80;
    this.img_h = 30;
  }

  void moveRight() {
    // Update the position of the shape
    this.location.x = this.location.x + ( this.xspeed * this.left_to_right_direction );

// Test to see if the shape exceeds the boundaries of the screen.
//If it does, reverse its direction by multiplying by -1.
    if (this.location.x > width ) {
      this.location.x = -10;
      this.location.y = random(0, height);
    }
  }


  void moveLeft() {
    // Update the position of the shape
    this.location.x = this.location.x + ( this.xspeed * this.right_to_left_direction );
   
    // Test to see if the shape exceeds the boundaries of the screen
    // If it does, reverse its direction by multiplying by -1
    if (this.location.x <= 0 ) {
      this.location.x = width ;
      this.location.y = random(0, height);
    }
  }

  void show() {
    noStroke();
    image(this.img, this.location.x, this.location.y, this.img_w, this.img_h);
  }
  
//checks the collusion of ball with rocket objects.
  boolean checkCollision(Kirby b) {
    if (b.location.x > this.location.x && b.location.x <  this.location.x+ this.img_w/2 && 
      b.location.y > this.location.y && b.location.y < this.location.y+ this.img_h/2) {
      return true;
    } else {
      return false;
    }
  }
}

//enemy 3

class KingDede extends Enemy {
  PVector velocity;
  float img_w;
  float img_h ;
  boolean fall;
  KingDede(float x, float y, float x_vel, float y_vel, String imageFileName) {
    super(x, y);
    this.velocity = new PVector(x_vel, y_vel);
    this.img = loadImage(imageFileName);
    this.img_w = 30;
    this.img_h = 30;
    this.fall = false;
  }

  void move() {
    if (this.fall == false) {
      if ((this.location.x > width) || (this.location.x < 0)) { 
        this.velocity.x = this.velocity.x * -1;
      } 
      if ((this.location.y > height) || (this.location.y < 0)) { 
        this.velocity.y = this.velocity.y * -1;
      }
    }
  }

  void show() {
    noStroke();
    image(this.img, this.location.x, this.location.y, 80, 60);
  }

//checks collusion of ball with Kingdede.
  boolean checkCollision(Kirby b) {
    if (dist(b.location.x, b.location.y, this.location.x + this.img_w/2, this.location.y+ this.img_h/2) < this.img_w) {
      return true;
    } else {
      return false;
    }
  }
}
