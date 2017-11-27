local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local physics = require( "physics" )

--physics.setDrawMode("hybrid")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- These values are set for easier access later on.
local acw = display.actualContentWidth
local ach = display.actualContentHeight
local cx = display.contentCenterX
local cy = display.contentCenterY
local top = display.screenOriginY
local left = display.screenOriginX
local right = display.viewableContentWidth - left
local bottom = display.viewableContentHeight - display.screenOriginY

local onTilt, dropCoins, onMenuTouch, onGlobalCollision -- forward declares for functions
local tmr_startGame, tmr_dropCoins -- forward declares for our timers
local player, playerScore -- forward declares for our player and player score
local playerScoreCounter = 0 -- a counter to keep track of player points
local coins = {} -- a table to store the coin objects
local coinCounter = 1 -- a counter to track the number of coins
local sensitivity = 2000 -- adjust this value to make the player more slower or quicker
local motionx = 0
local speed = 4


-- -----------------------------------------------------------------------------------
-- Scene event functions

-- This function will move the player based on x axis tilt.
onTilt = function(event)
    player:setLinearVelocity( sensitivity * event.xGravity, 0 )        
    return true
end

-- Create the coins that will drop from the sky for the player to catch.
dropCoins = function()
  physics.start()
  coins[coinCounter] = display.newImageRect("images/coin.png", 110, 110)
    coins[coinCounter].x = math.random(left, right)
    coins[coinCounter].y = top - 60
    physics.addBody(coins[coinCounter], {radius=55})
    coins[coinCounter].myName = "coins"

  coinCounter = coinCounter + 1 
end

-- Return the player to the menu and stop the game from running. We'll also run through the coins table to remove all coins. 
onMenuTouch = function(event)
  if(event.phase == "began") then 
    Runtime:removeEventListener("accelerometer", onTilt )
    Runtime:removeEventListener( "collision", onGlobalCollision )
    timer.cancel(tmr_dropCoins)

    for i=1,coinCounter do
      if(coins[i]) then 
        display.remove(coins[i])
      end
    end

    composer.gotoScene("menu", "fade")
  end
end

-- Our global collision detector to detect colliding objects between player/coin and coin/floor. The player score will then go up or down accordingly.
onGlobalCollision = function(event)

    local obj1 = event.object1 -- store the first object
    local obj2 = event.object2 -- store the second object

    local function decrementScore() -- decrease player score
      playerScoreCounter = playerScoreCounter - 1
      playerScore.text = "Score: "..playerScoreCounter
    end

    local function fadeObject(obj) -- fade the coins out when they hit the floor
      obj.myName = "lostCoin"
      decrementScore()
      transition.to(obj, {alpha = 0, onComplete=function(self) display.remove(self); end})
    end

    local function incrementScore(obj) -- increase the player score
      obj.myName = "grabbedCoin"
      transition.to(obj, {alpha = 0, onComplete=function(self) display.remove(self); end})
      playerScoreCounter = playerScoreCounter + 1
      playerScore.text = "Score: "..playerScoreCounter
    end

    if ( event.phase == "began" ) then
      if(obj1.myName == "coins" and obj2.myName == "floor") then -- listen for coins/floor collision   
        timer.performWithDelay(1, function() fadeObject(obj1); end, 1) -- don't ever remove an object in the middle of collision detection. Wait until the collision is over
      end
      if(obj1.myName == "floor" and obj2.myName == "coins") then -- listen for floor/coins collision
        timer.performWithDelay(1, function() fadeObject(obj2); end, 1)
      end

      if(obj1.myName == "player" and obj2.myName == "coins") then -- listen for player/coins collision
        timer.performWithDelay(1, function() incrementScore(obj2); end, 1)
      end
      if(obj1.myName == "coins" and obj2.myName == "player") then -- listen for coins/player collision
        timer.performWithDelay(1, function() incrementScore(obj1); end, 1)
      end
    end
end

-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
  physics.start()
  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen
  local background = display.newImageRect(sceneGroup, "images/cbackground.jpg", acw, ach)
  	background.x = cx
  	background.y = cy
    

  -- Add in a graphic for our floor. This is the visual piece only
  local floor = display.newImageRect(sceneGroup, "images/platform.png", 1600, 210)
    floor.x = cx
    floor.y = bottom - 100

  -- I want the player to look like they are 'standing' on the floor so I create a rectangle that acts as the floor. The player will stand on this object. 
  local floorPhysics = display.newRect(sceneGroup, 0, 0, acw, 50)
    floorPhysics.x = cx
    floorPhysics.y = floor.y + 30
    floorPhysics:setFillColor(0,0,0,0.01)
    floorPhysics.myName = "floor"
    physics.addBody(floorPhysics, "static")

  -- Create a left/right wall boundary. These objects are static and do not respond to gravity.
  local leftWall = display.newRect(sceneGroup, 0, 0, 40, ach)
    leftWall.x = left - 25
    leftWall.y = cy
    leftWall.myName = "wall"
    physics.addBody(leftWall, "static")

  local rightWall = display.newRect(sceneGroup, 0, 0, 40, ach)
    rightWall.x = right + 25
    rightWall.y = cy
    rightWall.myName = "wall"
    physics.addBody(rightWall, "static")

  -- Create two obstacles to give our game some flair
  local obstacle1 = display.newRect(sceneGroup, 150, 400, 300, 120)
    obstacle1.myName = "obstacle"
    obstacle1.rotation = 20
    obstacle1:setFillColor(0.5)

    physics.addBody(obstacle1, "static")

  local obstacle2 = display.newImageRect(sceneGroup, "images/obstacle2.png", 100, 100)
    obstacle2.x = math.random(500,600)
    obstacle2.y = 625
    obstacle2.myName = "obstacle"
    obstacle2.rotation = -10
    physics.addBody(obstacle2, "static")
  
  local obstacle3 = display.newImageRect(sceneGroup, "images/obstacle3.png", 140, 140)
    obstacle3.x = math.random(700,800)
    obstacle3.y = 950
    obstacle3.myName = "obstacle"
    obstacle3.rotation = -10
    physics.addBody(obstacle3, "static")

  local obstacle4 = display.newRect(sceneGroup, 1300, 1200, 300, 100)
    obstacle4.myName = "obstacle"
    obstacle4.rotation = - 30
    obstacle4:setFillColor(0.5)
    physics.addBody(obstacle4, "static")

  local obstacle5 = display.newImageRect(sceneGroup, "images/obstacle3.png", 140, 140)
    obstacle5.x = math.random(200,300)
    obstacle5.y = 1500
    obstacle5.myName = "obstacle"
    obstacle5.rotation = -10
    physics.addBody(obstacle5, "static")
  
   local obstacle6 = display.newRect(sceneGroup, 900, 1640, 300, 100)
    obstacle6.myName = "obstacle"
    obstacle6.rotation = 40
    obstacle6:setFillColor(0.5)
    physics.addBody(obstacle6, "static")



  -- Create a menu button to allow the player to go back to the menu
  local btn_menu = widget.newButton({
      left = 100,
      top = 200,
      width = 200,
      height = 200,
      label = "Menu",
      font = native.DroidSans,
      fontSize = 60, 
      defaultFile = "images/button1.png",
      overFile = "images/button2.png",      
      onEvent = onMenuTouch
    }
  )
    btn_menu.x = left + 100
    btn_menu.y = top + 100
  sceneGroup:insert(btn_menu)

  -- A visual indicator of the player score
  playerScore = display.newText(sceneGroup, "Score: 0", 0, 0, native.systemFontBold, 64)
    playerScore.anchorX = 1
    playerScore.anchorY = 0
    playerScore.x = right - 10
    playerScore.y = top + 10

  -- Add the player!
  player = display.newImageRect(sceneGroup, "images/papaMonkey.png", 500, 500)
    player.x = cx
    player.y = floor.y - 275
    physics.addBody(player, "dynamic", {friction = 1.0, bounce = 0 })
    player.myName = "player"
    player.isFixedRotation = true
-- control player with buttons
--Left Button
  local leftBtn = widget.newButton{
    left = -10,
		top = 2350,
		width = 350,
		height = 200,
		defaultFile = "images/challengeBtn(left).png",
		overFile = "images/challengeBtn(leftOver).png",
		onEvent = moveLeft
  }
--RightButton
   local rightBtn = widget.newButton{
    left = 1105,
		top = 2350,
		width = 350,
		height = 200,
		defaultFile = "images/challengeBtn(right).png",
		overFile = "images/challengeBtn(rightOver).png",
		onEvet = moveRight
  }
--Move player Left
  local function moveLeft(event)
    player.x = player.x - 50
  end
--Move player right
  local function moveRight(event)
    player.x = player.x + 50
  end
-- add event listners to move player
  rightBtn:addEventListener("touch", moveRight)
  leftBtn:addEventListener("touch", moveLeft)
-----Creating a timer
-----timer setup
local timeLimit = 35
timeLeft = display.newText(sceneGroup, "Time Left: " ..timeLimit, 160, 20, native.systemFontBold, 100)
  timeLeft.x = display.contentCenterX
  timeLeft.y = 100
timeLeft:setTextColor(255,0,0)


local function timerDown()
  timeLimit = timeLimit-1
  timeLeft.text = "Time Left: " ..timeLimit
    if(timeLimit == 0) then
      composer.gotoScene("menu", fade, 500)
      Runtime:removeEventListener( "collision", onGlobalCollision )
      Runtime:removeEventListener("accelerometer", onTilt )
      timer.cancel(tmr_dropCoins)

      for i=1,coinCounter do
        if(coins[i]) then 
          display.remove(coins[i])
        end
      end
      
    end
  end
  timer.performWithDelay(1000, timerDown, timeLimit)
end 
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
      -- Code here runs when the scene is entirely on screen
      tmr_startGame = timer.performWithDelay(1250, startGame, 1) -- allow the player to move shortly after the game has started
      tmr_dropCoins = timer.performWithDelay(800, dropCoins, 0) -- start dropping coins!
      Runtime:addEventListener( "collision", onGlobalCollision ) -- add an event listener to detect collisions
      
    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
      -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene