
local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not reccycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    local textArea, line
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Event Handlers
	local function onHomeRelease(event)
		--Log Skip
if not file then
		print( "File error: " .. errorString )
else
		file:write("Story was skipped\n")
end
		composer.gotoScene( "menu", "fade", 500 )
		return true
	end

local line = "What is this strange place... woah!"

local bgStory = display.newImageRect("images/cave.jpg", 800, 1400 )
bgStory.rotation = 90
bgStory.width = display.contentHeight
bgStory.height = display.contentWidth
bgStory.x = display.contentWidth / 2
bgStory.y = display.contentHeight / 2

local speechB = display.newImageRect("images/speechBubble.png", display.contentHeight, 330 )
speechB.rotation = 90
speechB.x = 50
speechB.y = 1300

local papaM= display.newImageRect("images/papaMonkey.png", 640, 480 )
papaM.rotation = 90
papaM.x = 450
papaM.y = 0

 textArea = {
	text = line,
    x = 0,
    y = 1280,
    width = 2000,
    height = 300,
	font = native.DroidSans,
	fontSize = 60,
	align = "center",
      -- Alignment parameter
	}

    line = display.newText(textArea)
    line:setFillColor(0,0,0)
    line.rotation = 90

transition.to(papaM, {time = 4000, x = 450 , y = 1300, onComplete = transition.to(
    papaM, {time = 1000, x = 650, y = 1300})})

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
