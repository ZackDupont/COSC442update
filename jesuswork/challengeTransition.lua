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
local title
local bgMusic

-----------------------------------------------------------------------------------------

-- Event Handlers
-- Tutorial handler
local function onNextRelease(event)
	--Log Press
if not file then
		print( "File error: " .. errorString )
else
		file:write("Continued to Challenge \n")
end
	composer.removeScene("challengeTransition")
	composer.gotoScene( "challenge", "fade", 500 )
	return true
end

-- Level 1 handler
local function onHomeRelease(event)
	--Log Press
if not file then
		print( "File error: " .. errorString )
else
		file:write("Exited before challenge \n")
end
	composer.removeScene("challengeTransition")
	composer.gotoScene( "Menu", "fade", 500 )
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
	local bgMain = display.newImage( sceneGroup, "images/transitionCBackground.jpg", true)
	bgMain.rotation = 90
	bgMain.width = display.contentHeight
	bgMain.height = display.contentWidth
	bgMain.x = display.contentWidth / 2
	bgMain.y = display.contentHeight / 2

	-- Game Title
	local titleInfo = {
		text = "Which is the correct spelling for this animal? \n A) LIAN \n B) LION \n \n Get ready to rotate your phone upright!",
		x = 850,
		y = 1280,
		font = native.DroidSans,
		fontSize = 120,
        
	}
	local title = display.newText(titleInfo)
	title:setFillColor(1,0,0)
	title.rotation = 90


	-- Menu Buttons
	nextBtn = widget.newButton{
		left = -250,
		top = 230,
		width = 750,
		height = 300,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Start Game",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onNextRelease
	}
	nextBtn.rotation = 90

	homeBtn = widget.newButton{
		left = -250,
		top = 2050,
		width = 750,
		height = 300,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Main Menu",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onHomeRelease
	}
	homeBtn.rotation = 90

	-- all display objects must be inserted into group
	sceneGroup:insert(bgMain)
	sceneGroup:insert(title)
	sceneGroup:insert(nextBtn)
	sceneGroup:insert(homeBtn)

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
