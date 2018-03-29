-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn, radioButton1, radioButton2

local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end
 
-- Create a group for the radio button set
local radioGroup = display.newGroup()
 
-- Create two associated radio buttons (inserted into the same display group)
local radioButton1 = widget.newSwitch(
    {
         x = display.contentWidth/4, 
        y = display.contentHeight/3+130,
        style = "radio",
        id = "RadioButton1",
        initialSwitchState = false,
        onPress = onSwitchPress
    }
)
radioGroup:insert( radioButton1 )
 
local radioButton2 = widget.newSwitch(
    {
        x = display.contentWidth/2 + 100, 
       y = display.contentHeight/3+130,
        style = "radio",
        id = "RadioButton2",
        onPress = onSwitchPress
    }
)
radioGroup:insert( radioButton2 )


-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	if radioButton1.isOn == true
	then
	composer.gotoScene( "level1", "fromTop", 500 )
	elseif radioButton2.isOn == true
	then
	composer.gotoScene( "level2", "fromTop", 500 )
	end
	return true	-- indicates successful touch
end





function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newRect(  display.contentWidth/2, display.contentHeight/2, display.actualContentWidth, display.actualContentHeight,1 )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	--Generate Title Backgrounds
	local titleRec1 = display.newRect(  display.contentWidth/2, display.contentHeight/5,display.contentWidth, display.contentHeight/8)
	titleRec1:setFillColor(0,.5,1)
	local titleRec2 = display.newRect(  display.contentWidth/2, display.contentHeight/5,display.contentWidth, display.contentHeight/8-7)
	titleRec2:setFillColor(1,1,1)
	
	-- Generate  Password Title
	local generateTitle = display.newText("Generate A Password For...",display.contentWidth/2, display.contentHeight/5,native.systemFontBold,20)
	generateTitle:setFillColor(0,.5,1)


	-- Student Image
	local studentImg = display.newImage("student_rng.png",display.contentWidth/4, display.contentHeight/3+20)
	local studentText =  display.newText("Student",display.contentWidth/4, display.contentHeight/3+90,native.systemFontBold,15)
	studentText:setFillColor( 0.6, 0.6, 0.6 )

	-- Professor Image
	local professorImg = display.newImage("professor_rng.png",display.contentWidth/2 + 100, display.contentHeight/3+20)
	local professorText =  display.newText("Professor",display.contentWidth/2 + 100, display.contentHeight/3+90,native.systemFontBold,15)
	professorText:setFillColor( 0.6, 0.6, 0.6 )

	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Generate",
		labelColor = { default={1,1,1}, over={1,1,1} },
		font = native.systemFontBold,
		defaultFile="GenButton.png",
		overFile="GenButton.png",
		width=display.contentWidth-50, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 125
	
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
 	sceneGroup:insert(radioButton1)
	sceneGroup:insert(radioButton2)
	sceneGroup:insert( playBtn )
	sceneGroup:insert( titleRec1 )
	sceneGroup:insert( titleRec2 )
	sceneGroup:insert( generateTitle )
	sceneGroup:insert( professorText )
	sceneGroup:insert( studentText )
	sceneGroup:insert( studentImg )
	sceneGroup:insert( professorImg )
	
	
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
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene