--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

IntroState = Class{__includes = BaseState}


function IntroState:init()
    self.counter = 0
    Timer.after(2, function() gSounds['intro']:play() end)

end

function IntroState:update(dt)
    Timer.update(dt)
    self.counter = self.counter + 1 * dt

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    	gSounds['start']:play()
        gStateMachine:change('start')
    end

    if self.counter > 17 then
        gStateMachine:change('start')
    end
end

function IntroState:render()
    if self.counter < 2 then
        love.graphics.draw(gTextures[2], 0, 0)
    elseif self.counter < 6 then
        love.graphics.draw(gTextures[3], 0, 0)
    elseif self.counter < 10 then
        love.graphics.draw(gTextures[4], 0, 0)
    elseif self.counter < 13.4 then
        love.graphics.draw(gTextures[5], 0, 0)
    elseif self.counter < 15.5 then
        love.graphics.draw(gTextures[6], 0, 0)
    elseif self.counter >= 15.5 then
        love.graphics.draw(gTextures[7], 0, 0)
    end
    
end