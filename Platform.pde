class Platform {
  PImage platformImg;
  PVector location;
  color c;
  float img_w;
  float img_h;

  // this variable controls the horizontal movement of the logs
  float x_speed = 0;
  float y_speed = 0.5;

  Platform (float x, float y, color colour, float w, float h, String image_name) {
    this.location =new PVector(x, y);
    this.c = colour;
    this.img_w = w;
    this.img_h = h;
    this.platformImg = loadImage(image_name);
  }

  void showPlatform() {
    noStroke();
    image(this.platformImg, this.location.x, this.location.y, this.img_w, this.img_h);
  }

//how the platform moves
  void moveLog() {
    this.location.x = this.location.x + this.x_speed;
    this.location.y = this.location.y + this.y_speed;
    if (this.location.x <= 0 || this.location.x >= width - this.img_w) {
      this.x_speed = this.x_speed * -1;
    }

    if (this.location.y > height) {
      this.location.y = -10;
      this.location.x = random(this.img_w, width-this.img_w);
    }
  }
}
