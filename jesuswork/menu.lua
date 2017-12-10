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
local playBtn
local statBtn
local credBtn
local testBtn
local title
local bgMusic
local moneyBtn

-----------------------------------------------------------------------------------------

-- Event Handlers
-- Play button handler
local function onPlayRelease(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Play button was pressed\n")
	end

	composer.gotoScene( "levelSelect", "fade", 500 )
	return true
end

-- Stats button handler
local function onStoryRelease(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Story Viewed\n")
	end

	composer.gotoScene ("story", "fade", 500)
	return true
end

-- Stats button handler
local function onTestRelease(event)
	--Finish writing to stats
	io.close(file)
	native.showAlert("Thanks for playing!", "PapaMonkey thanks you for joining him on this extravagent advanture.")
	return true
end

-- Credits button handler
local function onCreditRelease(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Credits Viewed\n")
	end

	native.showAlert("Papa Monkey's Extravagent Credits",
		"Developers: Zack Dupont, George Grafton, Sam Hunt \nManagement: Zack Dupont, George Grafton, Sam Hunt \nProject Leader(s): Zack Dupont, George Grafton, Sam Hunt \nThrilling Storyline: Zack Dupont, George Grafton, Sam Hunt \nMusic: Sam Hunt \nSpeech Bubbles: Freepik.com")
	return true
end

local function onMoneyRelease(event)
	--Log Press
	if not file then
		print( "File error: " .. errorString )
	else
		file:write("Money Mode Played\n")
	end

	composer.gotoScene ("challengeTransition", "fade", 500)
	return true
end 

-- Music Reset Handler
-- local function resetBgMusic(event)
--     if event.completed == false and event.phase == "stopped" then
--         audio.setVolume ( 1, {channel=1 })
--         audio.rewind (bgMusic)
--     end
-- end

-- Music Player Handler
local function playBgMusic()
        audio.play(bgMusic, {channel=1, loops=0,
        onComplete=resetBgMusic} )
end

-----------------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view
 
	-- Background image
	local bgMain = display.newImage( sceneGroup, "images/bgMain.jpg", true)
	bgMain.rotation = 90
	bgMain.width = display.contentHeight
	bgMain.height = display.contentWidth
	bgMain.x = display.contentWidth / 2
	bgMain.y = display.contentHeight / 2


  

	-- Game Title
	local titleInfo = {
		text = "Papa Monkey's Fishing Extravaganza",
		x = 1250,
		y = 1280,
		font = native.DroidSans,
		fontSize = 140
	}
	local title = display.newText(titleInfo)
	title:setFillColor(0,0,0)
	title.rotation = 90


	
	-- Menu Buttons
	-- Start Button
	playBtn = widget.newButton{
		left = 700,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Play",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onPlayRelease
	}
	playBtn.rotation = 90

	-- Story Button
	storyBtn = widget.newButton{
		left = 400,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Story",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onStoryRelease
	}
	storyBtn.rotation = 90

	-- Credits Button
	credBtn = widget.newButton{
		left = 100,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Credits",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onCreditRelease
	}
	credBtn.rotation = 90

	-- Test Button
	testBtn = widget.newButton{
		left = 0,
		top = 100,
		width = 200,
		height = 100,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "End Test",
		font = native.DroidSans,
		fontSize = 40,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onTestRelease
	}
	testBtn.rotation = 90

	moneyBtn = widget.newButton{
		left = -480,
		top = 1150,
		width = 1200,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Money Mode",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.3,0.21,1}, over = {0,0,0}},
		onRelease = onMoneyRelease
	}
	moneyBtn.rotation = 90

	-- all display objects must be inserted into group
	sceneGroup:insert(bgMain)
	sceneGroup:insert(title)
	sceneGroup:insert(playBtn)
	sceneGroup:insert(storyBtn)
	sceneGroup:insert(credBtn)
	sceneGroup:insert(testBtn)
	sceneGroup:insert(moneyBtn)
	

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

	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
	if statBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
	if credBtn then
		playBtn:removeSelf()
		playBtn = nil
	end

	if moneyBtn then
		playBtn:removeSelf()
		playBtn = nil
	end

	file = nil
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
