--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

StartState = Class{__includes = BaseState}

-- which option is being highlighted
local highlighted = 1

function StartState:init()
    -- reset the timers each time
    Timer.clear()
end

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') then
        if highlighted == 1 then
            highlighted = 1
        elseif highlighted == 2 then
            gSounds['start']:stop()
            gSounds['start']:play()
            highlighted = 1
        elseif highlighted == 3 then
            gSounds['start']:stop()
            gSounds['start']:play()
            highlighted = 2
        end
    elseif love.keyboard.wasPressed('down') then
        if highlighted == 1 then
            gSounds['start']:stop()
            gSounds['start']:play()
            highlighted = 2
        elseif highlighted == 2 then
            gSounds['start']:stop()
            gSounds['start']:play()
            highlighted = 3
        elseif highlighted == 3 then
            highlighted = 3
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['intro']:stop()

        if highlighted == 1 then
            gSounds['start']:play()
            gStateMachine:change('play', {level = 0})
        elseif highlighted == 2 then
            gSounds['start']:play()
            gStateMachine:change('play', {level = 1})
        elseif highlighted == 3 then
            gSounds['start']:play()
            love.event.quit()
        end

    end
end

function StartState:render()
    love.graphics.draw(gTextures['background1a'], 0, 0)
    love.graphics.draw(gTextures['background1b'], 0, 0)
    love.graphics.draw(gTextures['background1c'], 0, 0)

    love.graphics.draw(gTextures[7], 0, 0)

    --love.graphics.setFont(gFonts['medium'])
    --love.graphics.setColor(255, 255, 255, 255)
    --love.graphics.printf('El Sendero del', 0, VIRTUAL_HEIGHT / 2 - 20, VIRTUAL_WIDTH, 'center')

    --love.graphics.setFont(gFonts['large'])
    --love.graphics.setColor(255, 255, 255, 255)
    --love.graphics.printf('Hechicero', 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')

    -- Display menu
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(236, 0, 249, 120)
    if highlighted == 1 then
        love.graphics.setColor(236, 0, 249, 255)
    end
    love.graphics.printf("TUTORIAL", 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(236, 0, 249, 120)

    if highlighted == 2 then
        love.graphics.setColor(236, 0, 249, 255)
    end
    love.graphics.printf("COMENZAR", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(236, 0, 249, 120)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 3 then
        love.graphics.setColor(236, 0, 249, 255)
    end
    love.graphics.printf("SALIR", 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)
end