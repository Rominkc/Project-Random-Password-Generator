-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
-- include Corona's "widget" library
local widget = require "widget"
local pasteboard = require( "plugin.pasteboard" )
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
local playBtn1, backBtn, passwordText, newPass, passwordMaker
-- Capital Letters = 1-26, Lowercase Letters = 27-52, Numbers= 53-62, Symbols = 63-72

local allChars = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","!","@","#","$","%","^","&","*","-","+"}


-- Function to go back to menu
local function onBackBtnRelease()
	
	-- go to menu.lua scene
	composer.gotoScene( "menu", "fromLeft", 200 )
	return true	-- indicates successful touch
end
--Function that creates the password

local function passwordMaker(s)
    
	local allCharsInd = { }--Indexes all of the characters
    
	local pass = ""
       
	for k,v in ipairs(s) do
       
	allCharsInd[#allCharsInd+1] = (v)
    
		end
   
 	math.randomseed( os.time() )-- Makes it so the password is "always" random
   
   
	print(os.time() )
  
-- Creates random Password by concatinating values from the table
  
    
   
--Create password Must have One Uppercase, One Symbol, One Number 10 characters
   
	pass = allCharsInd[math.random(1,26)]..allCharsInd[math.random(27,52)]..allCharsInd[math.random(27,52)]..allCharsInd[math.random(27,52)]..allCharsInd[math.random(1,52)]..allCharsInd[math.random(1,52)]..allCharsInd[math.random(1,72)]..allCharsInd[math.random(1,72)]..allCharsInd[math.random(53,62)]..allCharsInd[math.random(63,72)]..""  
      
    
   
	passwordText.text = pass
 	return pass, print("This is the password: ".. pass)
    
--table.concat(allCharsInd,"\n"), print("This is the password: ".. pass)

end

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	passwordMaker(allChars)
	return true	-- indicates successful touch

end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()
	
	-- display a background image
	local background = display.newRect(  display.contentWidth/2, display.contentHeight/2, display.actualContentWidth, display.actualContentHeight,1 )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	
	-- Generate  Password Title
	local generateTitle = display.newText("Your New Password!",display.contentWidth/2, 150,native.systemFontBold,20)
	generateTitle:setFillColor(0,.5,1)


	-- Student Image
	local studentImg = display.newImage("student_rng.png",display.contentWidth/2, 20)
	local studentText =  display.newText("Student",display.contentWidth/2, 90,native.systemFontBold,15)
	studentText:setFillColor( 0.6, 0.6, 0.6 )

	-- create a widget button (which will loads menu.lua on release)
	 backBtn = widget.newButton{
		label="< Back",
		labelColor = { default={0,.5,1}, over={1,1,1} },
		font = native.systemFontBold,
		fontSize= 14,
		defaultFile="GenButton1.png",
		overFile="GenButton1.png",
		width=50, height=40,
		onRelease = onBackBtnRelease	-- event listener function
	}
	backBtn.x = 30
	backBtn.y = -25





	

	-- create a widget button (which will create password)
	 playBtn1 = widget.newButton{
		label="Generate Again",
		labelColor = { default={1,1,1}, over={1,1,1} },
		font = native.systemFontBold,
		defaultFile="GenButton.png",
		overFile="GenButton.png",
		width=display.contentWidth-50, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn1.x = display.contentCenterX
	playBtn1.y = display.contentHeight - 125

	--Create New Password
	newPass = ""
	passwordText = display.newText(newPass, display.contentWidth/2, 200,native.systemFontBold,20)
	passwordText:setFillColor(0,.5,1)
	
	-- Function to copy to clipboard	
	local function copyPassToClip() -- function to copy password to device clipboard
	pasteboard.copy( "string", passwordText.text )
	print("This was copied:",passwordText.text)
		end
	-- create a widget button (which will copy password to clipboard)
	 clipBoardBtn = widget.newButton{
		label="Copy To Clipboard",
		labelColor = { default={0,.5,1}, over={1,1,1} },
		font = native.systemFontBold,
		fontSize= 10,
		defaultFile="GenButton1.png",
		overFile="GenButton1.png",
		width=50, height=40,
		onRelease = copyPassToClip	-- event listener function
	}
	clipBoardBtn.x = display.contentWidth - 50
	clipBoardBtn.y = -25

	

	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( playBtn1 )
	
	sceneGroup:insert( backBtn )
	sceneGroup:insert( generateTitle )
	
	sceneGroup:insert( studentText )
	sceneGroup:insert( studentImg )
	
	
	sceneGroup:insert( passwordText )
	sceneGroup:insert( clipBoardBtn )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		
	
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		
		passwordMaker(allChars)
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	if playBtn1 then
		playBtn1:removeSelf()	-- widgets must be manually removed
		playBtn1 = nil
	end

	if passwordText then
		passwordText.text=""
		
	end
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene