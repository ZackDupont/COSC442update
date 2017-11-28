local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local secondsLeft
local round = 1
local clock

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Event Handlers
	local function onHomeRelease(event)
		--Log Skip
		if not file then
			print( "File error: " .. errorString )
		else
			file:write("Boss was abandoned\n")
		end
			composer.gotoScene( "menu", "fade", 500 )
			return true
		end

	-- Background Image
	local bgStory = display.newImageRect("images/bgStory.png", 800, 1400 )
	bgStory.rotation = 90
	bgStory.width = display.contentHeight
	bgStory.height = display.contentWidth
	bgStory.x = display.contentWidth / 2
	bgStory.y = display.contentHeight / 2

	-- Speech Bubble
	local speechB = display.newImageRect("images/speechBubble.png", display.contentHeight, 330 )
	speechB.rotation = 90
	speechB.x = 50
	speechB.y = 1300

	-- PapaMonkey
	local papaM= display.newImageRect("images/papaMonkey.png", 640, 480 )
	papaM.rotation = 90
	papaM.x = 400
	papaM.y = 300

	--Bag
	local bag= display.newImageRect("images/bag.png", 200, 200 )
	bag.rotation = 90
	bag.x = 500
	bag.y = 2100

	-- LavishLion
	local lavishL= display.newImageRect("images/lavishLion.png", 380, 540 )
	lavishL.rotation = 90
	lavishL.x = 470
	lavishL.y = 2300

	--Weapon
	local rod = display.newImageRect("images/frod.png", 300, 300)
	rod.x = papaM.x + 60
	rod.y = papaM.y + 130

	local hook = display.newImageRect("images/hook.png", 60, 30)
	hook.x = rod.x + 115
	hook.y = rod.y + 130

	local line = display.newLine(rod.x + 150,rod.y + 140 , hook.x + 10,rod.y + 140)
	line:setStrokeColor(0)
	line.strokeWidth = 5
	sceneGroup:insert(line)

	-- Storyline
	local line1 = "Papa Monkey: I have come to end your terrible tyrantry!"
	local line2 = "Lavish Lion: You'll never stop me, I have fished for many years and know how to spell words instantly!"
	local line3 = "Papa Monkey: Don't underestimate me, I learnt to spell to save my own family!"
	local line4 = "Lavish Lion: Well then I challenge you to a spelling duel!"
	local line5 = "Lavish Lion: Prepare to be defeated you extravagent silly monkey."
	local line6 = "Papa Monkey: Feeding my family has taught me to spell faster than you can imagine!"
	local line7 = "Choose the correct letter before time runs out to defeat Lavish Lion!"
	
	-- Text Area
	local textArea = {
		text = line1,
        x = 0,
        y = 1280,
        width = 2000,
        height = 300,
		font = native.DroidSans,
		fontSize = 60,
		align = "center"  -- Alignment parameter
	}

	local text = display.newText(textArea)
	text:setFillColor(0,0,0)
	text.rotation = 90
	local word

	local function moveLine (event)
		display.remove(line)
		hook.y = hook.y + 300
		line = display.newLine(rod.x + 150,rod.y + 140 ,rod.y + 180,hook.y + 10)
		line:setStrokeColor(0)
		line.strokeWidth = 5
		sceneGroup:insert(line)
		return true
	end

	local function returnLine (event)
		display.remove(line)
		hook.y = hook.y - 300
		bag.y = bag.y - 300
		line = display.newLine(rod.x + 150,rod.y + 140 ,rod.y + 180,hook.y + 10)
		line:setStrokeColor(0)
		line.strokeWidth = 5
		sceneGroup:insert(line)
		return true
	end

	local function returnHome(event)
		local function finish(event)
			if(event.action == "clicked") then
				composer.removeScene("boss")
				composer.gotoScene( "menu", "fade", 500 )
			end
		end
		
		native.showAlert("Papa Monkey's Completed Adventure", "Congratulations on beating Lavish Lion and completing the vowel level pack!\nCome back later for some beauty new levels that will put a smile on your face!", {"Return Home"}, finish)
	end

	local function endGame(event)
		text.text = "Lavish Lion: You may have one this battle but I will be back with harder challenges just you wait!"
		transition.to(lavishL, { time=4000, alpha = 0, x = 2000})
		timer.performWithDelay(5000, returnHome)
	end



	local function moveFishA()
			transition.to(fishA, {x = 700, y = -100, time=9000,onComplete=function() fishA.x = 700 fishA.y = 3000
				transition.to(fishA, {x = 700, y = -100, time=9000, onComplete=moveFishA()})
			end})
	end

	--Fish, Hand, Boat, Kite, Cute
	--Battle Handlers
	local function fishAPress(event)
		if round == 1 then
			text.text = "Sorry, fish A is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 2 then
			text.text = "Congratulations! You solved the second round, keep it up!."
			word.text = "B _ A T"
			round = 3
			moveLine()
		elseif round == 3 then
			text.text = "Sorry, fish A is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 4 then
			text.text = "Sorry, fish A is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 5 then
			text.text = "Sorry, fish A is the wrong answer."
			secondsLeft = secondsLeft - 5	
		end
	end

	local function fishIPress(event)
		if round == 1 then
			text.text = "Congratulations! You solved the first round, keep it up!."
			word.text = "H _ N D"
			round = 2
			moveLine()
		elseif round == 2 then
			text.text = "Sorry, fish I is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 3 then
			text.text = "Sorry, fish I is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 4 then
			text.text = "Sorry, fish I is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 5 then
			text.text = "Sorry, fish I is the wrong answer."
			secondsLeft = secondsLeft - 5	
		end
	end

	local function fishUPress(event)
		if round == 1 then
			text.text = "Sorry, fish U is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 2 then
			text.text = "Sorry, fish U is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 3 then
			text.text = "Sorry, fish U is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 4 then
			text.text = "Sorry, fish U is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 5 then
			text.text = "Congratulations! You solved the final round and defeated Lavish Lion!!! Keep on fishing you extravagent hero!"
			word.text = ""
			moveLine()
			timer.performWithDelay( 500, returnLine, 5 )
			secondsLeft = 999999
			clock.isVisible = false
			fishA.isVisible = false
			fishE.isVisible = false
			fishI.isVisible = false
			fishO.isVisible = false
			fishU.isVisible = false
			timer.performWithDelay (5000, endGame)
		end
	end

	local function fishEPress(event)
		if round == 1 then
			text.text = "Sorry, fish E is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 2 then
			text.text = "Sorry, fish E is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 3 then
			text.text = "Sorry, fish E is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 4 then
			text.text = "Congratulations! You solved the fourth round, one more to go!."
			word.text = "C _ T E"
			round = 5
			moveLine()
		elseif round == 5 then
			text.text = "Sorry, fish E is the wrong answer."
			secondsLeft = secondsLeft - 5	
		end
	end

	local function fishOPress(event)
		if round == 1 then
			text.text = "Sorry, fish O is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 2 then
			text.text = "Sorry, fish O is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 3 then
			text.text = "Congratulations! You solved the third round, keep it up!."
			word.text = "K I T _"
			round = 4
			moveLine()
		elseif round == 4 then
			text.text = "Sorry, fish O is the wrong answer."
			secondsLeft = secondsLeft - 5
		elseif round == 5 then
			text.text = "Sorry, fish O is the wrong answer."
			secondsLeft = secondsLeft - 5	
		end
	end


	--Battle
	local function startBattle( event )
		--Question
		text.text = line7
		word = display.newText("F _ S H", 1200, 1250, native.systemFont, 260)
		word.rotation = 90
		word:setFillColor(0,0,0)
		sceneGroup:insert(word)

		--Answers
		fishA = widget.newButton{
			left = 650,
			top = 1650,
			width = 200,
			height = 200,
			defaultFile = "images/fish.png",
			overFile = "images/fish.png",
			label = "",
			font = native.DroidSans,
			fontSize = 120,
			labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
			onRelease = fishAPress
		}

		fishI = widget.newButton{
			left = 650,
			top = 1400,
			width = 200,
			height = 200,
			defaultFile = "images/BPFish.png",
			overFile = "images/BPFish.png",
			label = "",
			font = native.DroidSans,
			fontSize = 120,
			labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
			onRelease = fishIPress
		}

		fishU = widget.newButton{
			left = 650,
			top = 1150,
			width = 200,
			height = 200,
			defaultFile = "images/GFish.png",
			overFile = "images/GFish.png",
			label = "",
			font = native.DroidSans,
			fontSize = 120,
			labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
			onRelease = fishUPress
		}

		fishE = widget.newButton{
			left = 650,
			top = 900,
			width = 200,
			height = 200,
			defaultFile = "images/RFish.png",
			overFile = "images/RFish.png",
			label = "",
			font = native.DroidSans,
			fontSize = 120,
			labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
			onRelease = fishEPress
		}

		fishO = widget.newButton{
			left = 650,
			top = 650,
			width = 200,
			height = 200,
			defaultFile = "images/YFish.png",
			overFile = "images/YFish.png",
			label = "",
			font = native.DroidSans,
			fontSize = 120,
			labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
			onRelease = fishOPress
		}

		sceneGroup:insert(fishA)
		sceneGroup:insert(fishI)
		sceneGroup:insert(fishU)
		sceneGroup:insert(fishE)
		sceneGroup:insert(fishO)
	end

	--Timer
	clock = display.newText("1:00", 300, display.contentCenterY, native.systemFontBold, 150)
	clock:setFillColor(1,0,0)
	clock.rotation = 90

	secondsLeft = 60

	local function updateTime()
		-- decrement the number of seconds
		secondsLeft = secondsLeft - 1
		
		-- time is tracked in seconds.  We need to convert it to minutes and seconds
		local minutes = math.floor( secondsLeft / 60 )
		local seconds = secondsLeft % 60

		-- make it a string using string format.  
		local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
		clock.text = timeDisplay
		
		local function timeOut(event)
			if(event.action == "clicked") then
				composer.removeScene("boss")
				composer.gotoScene( "menu", "fade", 500 )
			end
		end

		if secondsLeft < 0 then
			secondsLeft = 999999
			clock.isVisible = false
			native.showAlert("Papa Monkey's Failed Adventure", "Times up! \nBetter luck next time. \nPractice the levels more to better learn each word!", {"Return"}, timeOut)
		end
	end

	-- Terrible Line Switcher
	local function lineListener(event)
		if text.text == line1 then
			text.text = line2
		elseif text.text == line2 then
			text.text = line3
		elseif text.text == line3 then
			text.text = line4
		elseif text.text == line4 then
			text.text = line5
		elseif text.text == line5 then
			text.text = line6
			timer.performWithDelay(5000, startBattle, 1)
			timer.performWithDelay(1000, updateTime, secondsLeft-1 )
		end
	end

	timer.performWithDelay(5000, lineListener, 6)

	-- all display objects must be inserted into group
	sceneGroup:insert(bgStory)
	sceneGroup:insert(speechB)
	sceneGroup:insert(papaM)
	sceneGroup:insert(lavishL)
	sceneGroup:insert(rod)
	sceneGroup:insert(hook)
	sceneGroup:insert(line)
	sceneGroup:insert(clock)
	sceneGroup:insert(bag)
	sceneGroup:insert(text)
	-- text?


	homeBtn = widget.newButton{
		left = 1200,
		top = 100,
		width = 250,
		height = 150,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Menu",
		font = native.DroidSans,
		fontSize = 60,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onHomeRelease
	}
	homeBtn.rotation = 90
	sceneGroup:insert(homeBtn)


end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
