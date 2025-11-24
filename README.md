# Kirby-Game

A simple 2D platformer built with Processing — play as Kirby, collect coins, avoid enemies, and progress through stages.



# About

This project is a simple game titled Kirby-Game. It uses the Processing environment (Java mode) to bring a platform-style game experience. In the game you control Kirby, jump across platforms, collect coins, avoid or defeat enemies, and move through stage levels (via stageMovement.pde). The purpose is to experiment with basic game mechanics (movement, collision detection, enemy behaviour, audio integration) and polish gameplay loops.

# Features

- Playable character: Kirby (Kirby.pde) with movement + jump mechanics.

- Platforms for level traversal (Platform.pde).

- Enemies with basic AI/behaviour (Enemy.pde).

- Coin collection system (Coins.pde).

# Getting Started
Prerequisites

You’ll need the Processing IDE (Java mode) installed.

Basic Java/Processing familiarity is helpful.

Operating system: works on any OS supported by Processing (Windows, macOS, Linux).

# Setup & Run

1. Clone the repository:

git clone https://github.com/nmehjabin/Kirby-Game.git

2. Open the project folder in Processing.

3. Open the main sketch file (likely Kirby.pde or whichever is set as the entry point).

4. Click Run in Processing.

5. Use your keyboard (e.g. arrows or WASD) to move Kirby, jump, collect coins and avoid enemies.

# project structure
Kirby-Game/
│
├── data/                            ← assets like images, sounds, etc.  
│   ├── gameoverSound.wav  
│   └── jumSound.wav  
│
├── Kirby.pde                        ← main character logic  
├── Platform.pde                     ← platform/platform-collision logic  
├── Enemy.pde                        ← enemy behaviour  
├── Coins.pde                        ← coin collection logic  
├── stageMovement.pde                ← level progression / movement between stages  
├── README.md                        ← this file  
└── (other files/assets as needed)  


#How to Play

Move Kirby using the left/right arrow keys (or A/D).

Press Jump key (space or up arrow) to jump between platforms.

Collect coins scattered in each stage to increase your score.

Avoid enemies or defeat them (if implemented) to survive.

Advance to the next stage via the stage transition logic.

If Kirby collides with an enemy (or game over condition), the game ends with the “game over” sound.
