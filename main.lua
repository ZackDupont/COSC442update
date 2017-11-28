-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- Variables for shop purchases
_G.money = 10000
_G.hat = false
_G.glasses = false
_G.bait = false
_G.speed = false
_G.penalty = false
_G.cash = false

--Start stat tracking
_G.path = system.pathForFile( "statTracker.txt", system.DocumentsDirectory)
_G.file, errorString = io.open(path, "w")

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require("composer")

-- Seed the random number generator
math.randomseed( os.time() )

-- load menu screen
composer.gotoScene( "menu" )
