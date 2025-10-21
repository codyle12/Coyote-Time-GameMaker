/// @desc Handles directional left and right movement, jumping, and coyote time logic
/// @author Cody Le
/// @date 2025-10-20

// ----------------------------
// CREATE EVENT
// ----------------------------

// Helper function to set grounded state
function setOnGround(_val = true) {
    if _val == true {
        onGround = true;
        coyoteHangTimer = coyoteHangFrames;
    } else {
        onGround = false;
        coyoteHangTimer = 0;
    }
}

// Control setup
controlsSetup();

// Sprites
maskSpr = sPlayerIdle;
idleSpr = sPlayerIdle;
walkSpr = sPlayerWalk;
runSpr  = sPlayerRun;
jumpSpr = sPlayerJump;

// Movement setup
face = 1;
moveDir = 0;
runType = 0;
moveSpd[0] = 2;
moveSpd[1] = 3.5;
xspd = 0;
yspd = 0;

// Jumping setup
grav = 0.275;
termVel = 4;
onGround = true;
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;

// Jump values
jumpHoldFrames[0] = 18;
jspd[0] = -3.15;
jumpHoldFrames[1] = 10;
jspd[1] = -2.85;

// Coyote Time
coyoteHangFrames = 5;
coyoteHangTimer = 0;

// Jump Buffer
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;


// ----------------------------
// STEP EVENT
// ----------------------------

// Get inputs
getControls();

// X Movement
moveDir = rightKey - leftKey;
if moveDir != 0 { face = moveDir; }
runType = runKey;
xspd = moveDir * moveSpd[runType];

// X collision
var _subPixel = 0.5;
if place_meeting(x + xspd, y, oWall) {
    var _pixelCheck = _subPixel * sign(xspd);
    while !place_meeting(x + _pixelCheck, y, oWall) {
        x += _pixelCheck;
    }
    xspd = 0;
}
x += xspd;

// Y Movement (Gravity)
if coyoteHangTimer > 0 {
    coyoteHangTimer--;
} else {
    yspd += grav;
    setOnGround(false);
}

// Reset jump variables
if onGround {
    jumpCount = 0;
    jumpHoldTimer = 0;
    coyoteJumpTimer = coyoteJumpFrames;
} else {
    coyoteJumpTimer--;
    if jumpCount == 0 && coyoteJumpTimer <= 0 { jumpCount = 1; }
}

// Start jump
if jumpKeyBuffered && jumpCount < jumpMax {
    jumpKeyBuffered = false;
    jumpKeyBufferTimer = 0;
    jumpCount++;
    jumpHoldTimer = jumpHoldFrames[jumpCount - 1];
    setOnGround(false);
    coyoteJumpTimer = 0;
}

// Cut off jump when key released
if !jumpKey {
    jumpHoldTimer = 0;
}

// Jump logic
if jumpHoldTimer > 0 {
    yspd = jspd[jumpCount - 1];
    jumpHoldTimer--;
}

// Y Collision
if yspd > termVel { yspd = termVel; }
var _subPixel = 0.5;
if place_meeting(x, y + yspd, oWall) {
    var _pixelCheck = _subPixel * sign(yspd);
    while !place_meeting(x, y + _pixelCheck, oWall) {
        y += _pixelCheck;
    }
    yspd = 0;
}

// Check ground collision
if yspd >= 0 && place_meeting(x, y + 1, oWall) {
    setOnGround(true);
}

y += yspd;

// Sprite Control
if abs(xspd) > 0 { sprite_index = walkSpr; }
if abs(xspd) >= moveSpd[1] { sprite_index = runSpr; }
if xspd == 0 { sprite_index = idleSpr; }
if !onGround { sprite_index = jumpSpr; }

mask_index = idleSpr;
