# Coyote Time Explained + Basic 2D Platformer Mechanics for GameMaker 

Hello! This project demonstrates **Coyote Time** and how it works in a 2D platformer - Coyote Time is a mechanic that allows players to jump for a short grace period after dropping from a ledge. This sounds minimal, but it can really make a difference in platformers such as Celeste for creating "feel good movement"
Like I stated before, I was inspired by **Celeste**, a game known and critically acclaimed for its tight and responsive platforming controls, and by **Peyton Burnham**, who taught me the framework of 2D platformers and helped me consider about what makes a game feel enjoyable and addicting to play.
While Celeste was devloped in the **Monogame engine**, I wanted to share how this mechanic can be implemented in **GameMaker Studio**, a popular engine for beginners, so that more developers can implement it in their own indie games.
Even if you've never used GameMaker before, this repo includes my code that has the full implementation of Coyote Time + basic movement such as jumping, moving, the proper implementation of sprite animations, and jump buffering. Making this a good starting kit for those who want to tinker around with GameMaker to possibly make their own games in the future.

---

## Overview

This project includes: 
- **Coyote Time:** Allows for a short grace period of jumping after walking or falling off a ledge.
- **Jump Buffering:** Prevents cases where the player feels as if they "missed the jump" when pressing the jump button before landing.
- **Basic Movement** Left/Right movement with walking and running modes. Uses common inputs such as A and D directional keyboard inputs as well as gamepad d-pad compatibility.
- **Sprite Animations:** While sprites aren't provided in this repository. Code was included for smooth transitions between idle, walking, running, and jumping animations.
- **Collision:** Subpixel wall and floor checks for smooth physics and cohesive platforming feel.

---

## Project Structure

 Coyote-Time-GameMaker:  
│  
├── README.md                     # Project description and contact
├── /scripts                      # Code for basic movement & logic in GameMaker 
│   └── playerMovement.gml        # Includes both Create and Step event code with basic movement and smooth sprite animation integration

---

## Example Code (Create) 

Create Event: 
// Jumping
grav = 0.275;                     # The higher the number means stronger gravity (or faster falling) and vice versa
termVel = 4;                      # Terminal Velocity. This marks the fastest speed the player could fall (avoiding Jupiter's gravitational pull type falls)
onGround = true;                  # A boolean value used to check if the player is currently on the ground. It works with the coyoteHangTimer to determine when to start counting down on the Coyote Timer for the player to use.

//Coyote Time
coyoteHangFrames = 5;             # The number of frames or steps the player can take so they can still jump after leaving or falling off an edge.
coyoteHangTimer = 0;              # Timer that counts down after the player leaves the ground. When its higher than 0 the player can still jump even if midair. Grace period goes away once the timer hits 0.

---

## Future Plans / Contact

I'm still learning the ropes of how to make a 2D platformer myself, but feel free to reach out if you have any questions or sugguestions! I've been playing around with Unity lately so I'm hoping to one day include some useful guides for that Engine as well.
