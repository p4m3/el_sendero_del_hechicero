--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

TutorialState = Class{__includes = BaseState}

function TutorialState:init()
    Timer.clear()
    self.levelSizeX = 100
    self.levelSizeY = 10

    self.background1Scroll = 0
    self.background2Scroll = 0
    self.currentNote = 'hihat'
    self.score = 25 -- level Size divided by four gives us the total number of grids
    self.camX = 0
    self.paused = false
    -- used to control the blinking disco lights on the background
    self.rectangules_switch = false
    -- particle system belonging to the bricks, emitted when appearing
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 16)
    self.psystemx = 0
    self.psystemy = 6 * 16

    -- lasts between 0.1-0.25 seconds 
    self.psystem:setParticleLifetime(0.25, 1)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2
    self.psystem:setLinearAcceleration(-3,-5, 3, 5)
    -- spread of particles; normal looks more natural than uniform
    self.psystem:setAreaSpread('normal', 8, 4)

    gSounds['metronome']:play()

end

function TutorialState:enter(params)
    POWER_DOWN_NO_BRICKS = false
    self.level = params.level
    self.currentlevel = LevelMaker.generate(self.levelSizeX, self.levelSizeY, self.level)
    gSounds['song1']:stop()
    gSounds['song2']:stop()
    gSounds['song3']:stop()

    if self.level == 1 then
        self.currentsong = 'song1'
        BPM = 56.5

    elseif self.level == 2 then
        self.currentsong = 'song2'
        BPM = 67.5

    else

        self.currentsong = 'song3'
        BPM = 77.25

    end
    
    gSounds[self.currentsong]:play()
    gSounds[self.currentsong]:setVolume(1)

    --Timer.after(0.5, function() gSounds['guitar']:play() end)

    Timer.every(1 / (BPM / 60), function() 
                                    gSounds['metronome']:play()
                                    self.score = self.score - 1 
                                    self.rectangules_switch = not self.rectangules_switch
    
                                end)
    --[[
    Timer.every(0.25 / (BPM / 60), function() 
                                    gSounds['hihat']:stop()
                                    gSounds['hihat']:play()
                                end)
    ]]
    Timer.every(0.125 / (BPM / 60), function ()
                                    -- To animate de character switching from sprite 
                                    -- 1 to sprite 2
                                    self.player.switch = not self.player.switch
                                end)
    Timer.after(0.5 / (BPM / 60), function () Timer.every(1 / (BPM / 60), function() 
                                    --gSounds['guitar']:stop()
                                    --gSounds['guitar']:play()
                                    self.rectangules_switch = not self.rectangules_switch 
                                end) end)

    self.player = Player(self.currentlevel.tileMap, self.level, self.currentsong)

end

function TutorialState:update(dt)

    -- pause with the P key
    if self.paused then
        if love.keyboard.wasPressed('p') then
            self.paused = false
            gSounds['pause']:play()
            gSounds[self.currentsong]:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('p') then
        self.paused = true
        gSounds['pause']:play()
        gSounds[self.currentsong]:pause()
        return
    end

    Timer.update(dt)
    self.psystem:update(dt)

    self.currentlevel:update(dt)


    self.player:update(dt)

    self.camX = math.max(0,
        math.min(TILE_SIZE * self.currentlevel.tileMap.width - VIRTUAL_WIDTH,
        self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

    self.background1Scroll = (self.camX / 8) % 256
    self.background2Scroll = (self.camX / 2) % 256


    if love.keyboard.wasPressed('return') and self.player.spell then
        for j, tile in pairs(self.currentlevel.tileMap.tiles[7]) do
            if tile.id == TILE_ID_PREBRICK1 and tile.is_first then
                gSounds[self.currentNote]:stop()
                self.currentNote = 'hihat'
                gSounds[self.currentNote]:play()
                -- particle system code, so that there is an animation when the brick appears
                self.psystem:setColors(249, 22, 241, 50)
                self.psystem:setAreaSpread('normal', 4, 4)
                self.psystem:emit(16)
                self.psystemx = (j - 1) * 16 + 8

                tile.id = TILE_ID_BRICK1
                break
            elseif tile.id == TILE_ID_PREBRICK2 and tile.is_first then
                gSounds[self.currentNote]:stop()
                self.currentNote = 'guitar'
                gSounds[self.currentNote]:play()
                -- particle system code, so that there is an animation when the brick appears
                self.psystem:setColors(249, 22, 241, 50)
                self.psystem:setAreaSpread('normal', 8, 4)
                self.psystem:emit(16)
                self.psystemx = (j - 1) * 16 + 16

                tile.id = TILE_ID_BRICK2
                self.currentlevel.tileMap.tiles[7][j + 1].id = TILE_ID_BRICK2
                break
            elseif tile.id == TILE_ID_PREBRICK3 and tile.is_first then
                gSounds[self.currentNote]:stop()
                self.currentNote = 'punch'
                gSounds[self.currentNote]:play()
                -- particle system code, so that there is an animation when the brick appears
                self.psystem:setColors(249, 22, 241, 50)
                self.psystem:setAreaSpread('normal', 16, 4)
                self.psystem:emit(16)
                self.psystemx = (j - 1) * 16 + 32

                tile.id = TILE_ID_BRICK3
                self.currentlevel.tileMap.tiles[7][j + 1].id = TILE_ID_BRICK3
                self.currentlevel.tileMap.tiles[7][j + 2].id = TILE_ID_BRICK3
                self.currentlevel.tileMap.tiles[7][j + 3].id = TILE_ID_BRICK3
                break
            end
        end
    elseif love.keyboard.wasPressed('return') and not self.player.spell then
        if self.player.animation == 'walking' then
            gSounds['power_in']:play()
            gStateMachine:change('play', {level = self.level})
        else
            gSounds['power_in']:play()
        end

    end

end

function TutorialState:render()
    love.graphics.draw(gTextures['tutorial1'], 0, 0)

    -- push so that only this is translated and not the score
    love.graphics.push()

    love.graphics.translate(-math.floor(self.camX), 0)
    self.currentlevel:render()
    self.player:render()
    love.graphics.draw(self.psystem, self.psystemx, self.psystemy)

    if self.rectangules_switch then
        self:renderRectangulesA()
    else
        self:renderRectangulesB()
    end

    love.graphics.pop()

    love.graphics.draw(gTextures['tutorial2'], 0, 0)




    -- pause text, if paused
    if self.paused then
        love.graphics.setColor(0, 0, 0, 100)
        love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSA", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function TutorialState:renderRectangulesA()
    local rectangule_n = self.levelSizeX * 16 / 32
    local rectangule_width = 64
    local rectangule_height = self.levelSizeY * 16

    love.graphics.setColor(249, 22, 241, 15)
    for i = 0, rectangule_n do
        love.graphics.rectangle("fill", i * 128, 0, rectangule_width, rectangule_height)
    end
    love.graphics.setColor(255, 255, 255, 255)
end

function TutorialState:renderRectangulesB()
    local rectangule_n = self.levelSizeX * 16 / 32
    local rectangule_width = 64
    local rectangule_height = self.levelSizeY * 16

    love.graphics.setColor(249, 22, 241, 15)
    for i = 0, rectangule_n do
        love.graphics.rectangle("fill", i * 128 + 64, 0, rectangule_width, rectangule_height)
    end
    love.graphics.setColor(255, 255, 255, 255)
end

