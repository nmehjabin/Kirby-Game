/* Nadia Mehjabin <nm6088@bard.edu>
 Dec 17 2021
 CMSC 141
 Final Project
 Collaboration Statement: I worked on this assignment with tutor on collusion problems.
 sources: https://happycoding.io/tutorials/processing/collision-detection
 */

import processing.sound.*;     //importing sound 

SoundFile music;
SoundFile points;
SoundFile explosion;

String GAMESTATE;
PFont score_font;
ArrayList <Platform> platforms = new ArrayList<Platform>();
ArrayList <Bomb> bombs = new ArrayList<Bomb>();
ArrayList <Coins> coins = new ArrayList<Coins>();

Rocket roketRight;
Rocket roketLeft;
KingDede kd;
Kirby kirby;

PImage bg;
PImage coinsImg;
PImage intro_img;
PImage story_img;
PImage how_img;
PImage end_img;
PImage win_img;

int score = 0;

void Add_coins() {
  //condition of coins appearing on screen
  if (frameCount % 150 == 0) {
    Coins c = new Coins(random(0, width-50), random(0, height-50), 50, 50);
    coins.add(c);
  }
}

//GAMESTATE can be : INTRO/STORY/HOWTOPLAY/PLAYING/WINSCREEN/GAMEOVER


void setup () {
  GAMESTATE = "INTRO";

  size(800, 800);
  //soundfile
  music = new SoundFile(this, "backgroundmusic.mp3");
  points = new SoundFile(this, "soundforcoins.wav");
  explosion = new SoundFile(this, "explosion.wav");
  music.amp(0.2);
  music.loop();

  score_font = loadFont("NanumBrush-30.vlw");
  textFont(score_font);

  kirby = new Kirby (300, (height-80), "kirby.png");

  //loading images

  bg = loadImage("background.jpeg");
  bg.resize(800, 800);

  intro_img = loadImage("Intro.jpg");
  intro_img.resize(800, 800);

  story_img = loadImage("storypage.png");
  story_img.resize(800, 800);

  how_img = loadImage("howtoplay.jpg");
  how_img.resize(800, 800);

  end_img = loadImage("GameOverScreen-final.jpg");
  end_img.resize(800, 800);

  win_img = loadImage("endPage.png");
  win_img.resize(800, 800);

  coinsImg = loadImage("coin.gif");

  int num_coins =6;
  //adding coins
  for (int i =0; i < num_coins; i++) {
    Coins c = new Coins(random(0, width-50), random(0, height-50), 50, 50);
    coins.add(c);
  }

  // This block of code tries to generate non overlapping 
  // locations for the platforms

  int num_platforms = 10;
  ArrayList <Float> x_locs = new ArrayList<Float>();
  x_locs.add(random(0, width-100));

  ArrayList <Float> y_locs = new ArrayList<Float>();
  y_locs.add(random(0, height));

  float p_w = 100;    // platform width
  float p_h = 25;     // platform height

  int i = 0;
  while (i < num_platforms) {
    boolean overlapping = false;
    // candidate x, y
    float c_x = random(0, width-100);
    float c_y = random(0, height);
    for (int j = 0; j < i; j ++) {
      float p_x = x_locs.get(j);
      float p_y = y_locs.get(j);      
      float d = dist(c_x, c_y, p_x, p_y);
      float min_dist = sqrt(pow(p_w, 2) + pow(p_h, 2));
      if (d < 1.5*min_dist) {
        overlapping = true;
        break;
      }
    }

    if (overlapping == false) {
      x_locs.add(c_x);
      y_locs.add(c_y);
      i++;
    }
  } // END OF WHILE LOOP

  // AT THIS POINT WE HAVE the x_locs and y_locs populated with coordinates
  // where we can put the platforms
  // Next we draw the platforms

  for (int index =0; index < x_locs.size(); index++) {
    Platform candidate_p = new Platform(x_locs.get(index), y_locs.get(index), color(255, 255, 255), 100, 25, "img.png" );
    platforms.add(candidate_p);
  }// End of platform creation

  //Create bombs
  int num_bombs = 3;
  for (int l = 0; l < num_bombs; l ++) {
    Bomb b = new Bomb(random(l*width/num_bombs, width), random(0, height-20), "bomb.png");
    bombs.add(b);
  }
  //create rockets
  roketRight = new Rocket(random(-10, 0), random(0, height/2), "rocketRight.png");
  roketLeft = new Rocket(random(0, width+10), random(0, height), "rocketLeft.png");

  // Boss   
  kd = new KingDede(100, 1, 0.5, 0.5, "dede.png");
}

public void keyPressed () {
  if (key== CODED && keyCode == LEFT) {
    kirby.moveLeft();
  } else if (key== CODED && keyCode == RIGHT) {
    kirby.moveRight();
  }
}

void moveBallUp(Kirby b) {
  if (keyPressed && (keyCode == UP)) {
    kirby.velocity.y = -10;
    kirby.acc.y = 0.5;
  }
}


//  this function make sure:
//1. kirby does not go outside the left side of the window
//2. kirby does not go outside the right side of the window
//3. kirby does not go outside the bottom side of the window

void keepKirbyWithinWindow(Kirby kirby) {
  //checking to make sure kirby doesnt go underground
  //checking if the ball has hiten the lefy boundary
  if  (kirby.location.x - kirby_s < 0 ) {
    kirby.location.x = kirby_s;
  }
  // prevent kirby going outside the right sige of the window
  if  ( kirby.location.x > width - kirby_s ) {
    kirby.location.x = width - kirby_s;
  }
  // prevent kirby from going outside the window height
  if (kirby.location.y > (height - (kirby_s/2))) {
    kirby.acc.y = 0;
    kirby.velocity.y =0;
    kirby.location.y = (height - (kirby_s/2));
  }
}


void draw() {
  if (GAMESTATE == "INTRO") {
    background(intro_img);
    if (mousePressed == true) {
      if (mouseX> 352 && mouseX <458 && mouseY > 319 && mouseY <391) {
        GAMESTATE = "STORY";
      }
    }
  } else if (GAMESTATE == "STORY") {
    background(story_img);
    // if next button is pressed, take user to the how to play page
    if (mousePressed == true) {
      if (mouseX> 612 && mouseX <727 && mouseY > 709 && mouseY <767) {
        GAMESTATE = "HOWTOPLAY";
      }
    }
  } else if (GAMESTATE == "HOWTOPLAY") {
    background(how_img);
    if (mousePressed == true) {
      if (mouseX> 629 && mouseX <723 && mouseY > 608 && mouseY <727 ) {
        GAMESTATE = "PLAYING";
      }
    }
  } else if (GAMESTATE == "PLAYING") {
    background(bg);
    textSize(40);
    fill(128, 128, 128);
    text("Score", 10, 40);
    text(score, 10 + 80, 40);

    for (int i =0; i<coins.size(); i++) {
      Coins cn = coins.get(i);
      cn.showCoins();
    }
    kirby.update();
    // if up button is pressed, set the gravity and velocity
    moveBallUp(kirby);

    // make sure the ball stays within the window!
    keepKirbyWithinWindow(kirby);

    for (int i=0; i < platforms.size(); i++) {
      Platform platform = platforms.get(i);
      platform.moveLog();
      platform.showPlatform();

      // this function checks if kirby can land on a platform!
      boolean kirby_can_stand = kirby.canStand(platform);

      // check if the kirby is landing on a platform and can it stand
      // we make:
      //    1. kirby's y location is on the platform's y location
      //    2. stop the movement of the kirby!

      if (kirby_can_stand) {
        // while on the platform, we we want to jump, this if handles it!
        if (keyPressed && (keyCode == UP)) {
          kirby.velocity.y = -10;
          kirby.acc.y = 0.5;
        }
        // while on the platform, we we do not do anything, the ball should just
        //be where there platform is. It should ride the platform!
        else {
          kirby.location.y = platform.location.y - 20;

          // Since the kirby is on a platform, it should not move
          //so we make the velocity to platform's xspeed and accerlation to zero

          kirby.velocity = new PVector(platform.x_speed, 0);
          kirby.acc = new PVector(0, 0);
        }
      } // END OF Kirby_CAN_STAND IF

      // if kirby goes outside the platform, it should drop off the edge and fall
      // if kirby's x location < platform's x location OR ball's x location is outside the right edge of the
      // platform, then it should drop off!!

      if ((kirby.location.x < platform.location.x) || (kirby.location.x > platform.location.x + platform.img_w)) {
        kirby.acc = new PVector(0, 0.5);
      }
    }// END OF platform for loop

    // show the main character!
    image(kirby.img, kirby.location.x, kirby.location.y, kirby.img_w, kirby.img_h);

    //check the collusion of the kirby and coins
    for (Coins cn : coins ) {
      boolean coin_ball_collision = cn.checkCollision(kirby);
      if (coin_ball_collision == true) {

        if (cn.isAlive== true) {
          cn.gettingCoins();
          score = score + 10;

          //playing the sound for getting coins
          if (!points.isPlaying()) {
            points.play();
          }
        }
      }
    }

    Add_coins();

    //this is for the bomb
    for (int i=0; i < bombs.size(); i++) {
      Bomb bomb = bombs.get(i);
      bomb.show();
      boolean bomb_ball_collision = bomb.checkCollision(kirby);
      if (bomb_ball_collision == true) {
        score = score - 20;
        bomb.location.x = random(0, width-30);
        bomb.location.y = random(30, height-30);
      }
    }

    // Show the rocket that moves Right
    roketRight.moveRight();
    roketRight.show();
    boolean roketRight_ball_collision = roketRight.checkCollision(kirby);
    if (roketRight_ball_collision == true) {
      score = score - 10;
      //explosion sound
      if (!explosion.isPlaying()) {
        explosion.play();
      }
    }

    // Show the rocket that moves Left
    roketLeft.moveLeft();
    roketLeft.show();
    boolean roketLeft_ball_collision = roketLeft.checkCollision(kirby);
    if (roketLeft_ball_collision == true) {
      score = score - 10;
      //explosion sound
      if (!explosion.isPlaying()) {
        explosion.play();
      }
    }

    // BOSS arrival code, Dede comes after 3000 frames!
    if (frameCount > 3000) {
      kd.location.add(kd.velocity);
      kd.move();
      kd.show();
      boolean kd_ball_collision = kd.checkCollision(kirby);

      if ( kd_ball_collision == true) {

        // if there is enough points and there has been a collision
        // declare winner!
        if (score >=120) {
          kd.velocity.x = 8;
          kd.velocity.y = 8;
          kd.fall=true;
        } else {
          score = 0;
          GAMESTATE = "GAMEOVER";
          background(end_img);
        }
      } // END OF BALL & BOSS COLLISION IF
    } // END OF BOSS ARRIVAL IF
  } // END OF GAMESTATE == PLAYING IF
  else if (GAMESTATE == "GAMEOVER") {
    background(end_img);

    // if we press RETRY button we will take the user to the intro page again
    if (mouseX > 349 && mouseX <451 && mouseY > 389 && mouseY <446) {
      println(mouseX);
      println(mouseY);
      if (mousePressed == true) {

        //if (mouseX> 349 && mouseX <451 && mouseY > 389 && mouseY <446) {
        GAMESTATE = "PLAYING";
        score = 0;
        kirby = new Kirby (300, (height-80), "kirby.png");
      }
    }
  } else if (GAMESTATE == "WINSCREEN") {
    background(win_img);
    println(mouseX);
    println(mouseY);
    if (mouseX > 719 && mouseX < 773 && mouseY > 15 && mouseY < 53) {
      if (mousePressed == true) {
        exit();
      }
    }
  }

  // if we have kicked out kind dede
  if (kd.location.x > width + width/2) {
    if (GAMESTATE == "PLAYING") {
      GAMESTATE = "WINSCREEN";
      score = 0;
    }
  }
} // END OF DRAW
