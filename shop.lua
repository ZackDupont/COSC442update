--
-- Project: PapaMonkey
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2017 . All Rights Reserved.
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-----------------------------------------------------------------------------------------

-- forward declarations and other locals
local hat
local glasses
local bait
local title
local bgMusic
local shop

-----------------------------------------------------------------------------------------



-- Music Player Handler
local function playBgMusic()
        audio.play(bgMusic, {channel=1, loops=0,
        onComplete=resetBgMusic} )
end

-----------------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

	-- Money
  local balance = display.newText(sceneGroup, "Money: $" .. _G.money, 1250, 550, native.systemFont, 140 )
  balance:setFillColor(0,0,0)
  balance.rotation = 90

  -- x1.5 line speed
  local lineSpeed = display.newText(sceneGroup, "x1.5 LINE SPEED", 1000, 450, native.systemFont, 90)
  lineSpeed:setFillColor(1)
  lineSpeed.rotation = 90
  lineSpeed:toFront()

  -- Penalty text
  local penaltyText = display.newText(sceneGroup, "NO PENALTIES", 1000, 1275, native.systemFont, 90)
  penaltyText:setFillColor(1)
  penaltyText.rotation = 90
  penaltyText:toFront()

  -- Penalty text
  local bonus = display.newText(sceneGroup, "BONUS MONEY", 1000, 2050, native.systemFont, 90)
  bonus:setFillColor(1)
  bonus.rotation = 90
  bonus:toFront()


	-- Event Handlers
	local function onHomeRelease(event)
		--Log press
	if not file then
			print( "File error: " .. errorString )
	else
			file:write("Returned home\n")
	end
		composer.gotoScene( "menu", "fade", 500 )
		return true
	end

	-- Purchase hat
	local function onHatRelease(event)
		--Log press
	if not file then
			print( "File error: " .. errorString )
	else
			file:write("Purchased hat \n")
	end
	if _G.money >= 100 and _G.hat == false then
		_G.hat = true
		_G.money = _G.money - 100
		hatBtn:setLabel("Owned")
		balance.text = "Money: $" .. _G.money
	end
		return true
	end

	-- Purchase glasses
	local function onGlassesRelease(event)
		--Log press
	if not file then
			print( "File error: " .. errorString )
	else
			file:write("Purchased glasses\n")
	end

		if _G.money >= 500 and _G.glasses == false then
			_G.glasses = true
			_G.money = _G.money - 500
			glassesBtn:setLabel("Owned")
			balance.text = "Money: $" .. _G.money
		end

		return true
	end

	-- Purchase bait
	local function onBaitRelease(event)
		--Log press
	if not file then
			print( "File error: " .. errorString )
	else
			file:write("Purchased bait\n")
	end
	if _G.money >= 1000 and _G.bait == false then
		_G.bait = true
		_G.money = _G.money - 1000
		baitBtn:setLabel("Owned")
		balance.text = "Money: $" .. _G.money
	end
		return true
	end

  -- Purchase bonus reward
  local function onCashRelease(event)
    --Log press
  if not file then
      print( "File error: " .. errorString )
  else
      file:write("Purchased bonus cash\n")
  end
  if _G.money >= 1500 and _G.cash == false then
    _G.cash = true
    _G.money = _G.money - 1500
    cashBtn:setLabel("Owned")
    balance.text = "Money: $" .. _G.money
  end
    return true
  end

  -- Purchase no penalty
  local function onPenaltyRelease(event)
    --Log press
  if not file then
      print( "File error: " .. errorString )
  else
      file:write("Purchased penalty\n")
  end
  if _G.money >= 1000 and _G.penalty == false then
    _G.penalty = true
    _G.money = _G.money - 1000
    penaltyBtn:setLabel("Owned")
    balance.text = "Money: $" .. _G.money
  end
    return true
  end

  -- Purchase no penalty
  local function onSpeedRelease(event)
    --Log press
  if not file then
      print( "File error: " .. errorString )
  else
      file:write("Purchased penalty\n")
  end
  if _G.money >= 500 and _G.speed == false then
    _G.speed = true
    _G.money = _G.money - 500
    speedBtn:setLabel("Owned")
    balance.text = "Money: $" .. _G.money
  end
    return true
  end

	-- Background image
	local bgMain = display.newImage( sceneGroup, "images/bgMain.jpg", true)
	bgMain.rotation = 90
	bgMain.width = display.contentHeight
	bgMain.height = display.contentWidth
	bgMain.x = display.contentWidth / 2
	bgMain.y = display.contentHeight / 2

	-- Game Title
	local titleInfo = {
		text = "Shop",
		x = 1250,
		y = 1280,
		font = native.DroidSans,
		fontSize = 140
	}
	local title = display.newText(titleInfo)
	title:setFillColor(0,0,0)
	title.rotation = 90



	local glasses = display.newImageRect("images/glasses.png", 350, 200)
	glasses.x = 575
	glasses.y = 1265
	glasses.rotation = 90

	local hat = display.newImageRect("images/hat.png", 350, 200)
	hat.x = 575
	hat.y = 475
	hat.rotation = 90

	local bait = display.newImageRect("images/worm.png", 350, 200)
	bait.x = 575
	bait.y = 2050
	bait.rotation = 90


	-- Menu Buttons
	homeBtn = widget.newButton{
		left = -100,
		top = 1200,
		width = 400,
		height = 150,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Main Menu",
		font = native.DroidSans,
		fontSize = 60,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onHomeRelease
	}
	homeBtn.rotation = 90

	hatBtn = widget.newButton{
		left = 250,
		top = 350,
		width = 300,
		height = 125,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "$100",
		font = native.DroidSans,
		fontSize = 60,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onHatRelease
	}
	hatBtn.rotation = 90

	glassesBtn = widget.newButton{
		left = 250,
		top = 1200,
		width = 300,
		height = 125,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "$500",
		font = native.DroidSans,
		fontSize = 60,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onGlassesRelease
	}
	glassesBtn.rotation = 90

	baitBtn = widget.newButton{
		left = 250,
		top = 1950,
		width = 300,
		height = 125,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "$1000",
		font = native.DroidSans,
		fontSize = 60,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onBaitRelease
	}
	baitBtn.rotation = 90

  cashBtn = widget.newButton{
    left = 700,
    top = 1950,
    width = 300,
    height = 125,
    defaultFile = "images/button1.png",
    overFile = "images/button2.png",
    label = "$1500",
    font = native.DroidSans,
    fontSize = 60,
    labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
    onRelease = onCashRelease
  }
  cashBtn.rotation = 90

  penaltyBtn = widget.newButton{
    left = 700,
    top = 1200,
    width = 300,
    height = 125,
    defaultFile = "images/button1.png",
    overFile = "images/button2.png",
    label = "$1000",
    font = native.DroidSans,
    fontSize = 60,
    labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
    onRelease = onPenaltyRelease
  }
  penaltyBtn.rotation = 90

  speedBtn = widget.newButton{
    left = 700,
    top = 350,
    width = 300,
    height = 125,
    defaultFile = "images/button1.png",
    overFile = "images/button2.png",
    label = "$500",
    font = native.DroidSans,
    fontSize = 60,
    labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
    onRelease = onSpeedRelease
  }
  speedBtn.rotation = 90



	-- all display objects must be inserted into group
	sceneGroup:insert(bgMain)
	sceneGroup:insert(title)
  sceneGroup:insert(balance)
	sceneGroup:insert(homeBtn)
	sceneGroup:insert(hatBtn)
	sceneGroup:insert(glassesBtn)
	sceneGroup:insert(baitBtn)
  sceneGroup:insert(penaltyBtn)
  sceneGroup:insert(cashBtn)
  sceneGroup:insert(speedBtn)
	sceneGroup:insert(glasses)
	sceneGroup:insert(hat)
	sceneGroup:insert(bait)
  sceneGroup:insert(lineSpeed)
  sceneGroup:insert(penaltyText)
  sceneGroup:insert(bonus)





end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
	elseif phase == "did" then
		-- Start Background Music
		bgMusic = audio.loadStream("audio/menu.wav")
		playBgMusic()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- resetBgMusic()
	elseif phase == "did" then

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
