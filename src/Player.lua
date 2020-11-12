

Player = Class{}

function Player:init(map, level, currentsong)
	self.height = 20
	self.width = 16
	self.x = 64  - self.width + 5
	-- adding 2 to give a more realistic look considering the platform's rough surface
	self.y = VIRTUAL_HEIGHT - (TILE_SIZE * 3) - self.height + 2
	self.map = map
	-- 4 is the number of tiles the player should walk between each metronome click
	self.dx = (TILE_SIZE * 4) * BPM / 60
	self.dy = 1
	self.gravity = 1.5
	-- controlled by the metronome in playstate, makes the players animation change
	-- based on the rythm
	self.switch = false
	self.animation = 'falling'
	-- determines if we can receive inputs to make platforms appear, once the input is
	-- received it becomes a counter, once the counter gets to cero, times over and no more
	-- inputs are allowed
	self.spell = false
	self.level = level
	self.currentsong = currentsong

end

function Player:update(dt)

	local tileBottomLeft = self.map:pointToTile(self.x + 1, 
		self.y + self.height)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1,
    	self.y + self.height)
    local tilePlayerIs = self.map:pointToTile(self.x + self.width - 3,
    	self.y + self.height - 5)

    -- WINS THE LEVEL
	if self.x > TILE_SIZE * self.map.width - self.width then
		gSounds['start']:play()
        ATTEMPTS = 1
        -- finished game, eventually this should lead up to a credit state
		if self.level == 3 then
			gStateMachine:change('start')
        -- finished tutorial stage
        elseif self.level == 0 then
            gStateMachine:change('start')
		else
        	gStateMachine:change('play', {level = self.level + 1})
        end
    end

    -- COLLIDE WITH POWERS
    -- Music off power down, the music stops for 2 beats
    if tilePlayerIs.id == TILE_ID_POWER_MUSIC_OFF then
    	gSounds['power_in']:play()
    	gSounds[self.currentsong]:setVolume(0)

    	Timer.after(2 / (BPM / 60), function()
    		gSounds['power_out']:play()
    		gSounds[self.currentsong]:setVolume(1)
    	end)

    	tilePlayerIs.id = TILE_ID_EMPTY
    -- Bricks off power down, the bricks desappear for two beats
    elseif tilePlayerIs.id == TILE_ID_POWER_BRICKS_OFF then
    	gSounds['power_in']:play()
    	POWER_DOWN_NO_BRICKS = true

    	Timer.after(2 / (BPM / 60), function()
    		gSounds['power_out']:play()
    		POWER_DOWN_NO_BRICKS = false
    	end)

    	tilePlayerIs.id = TILE_ID_EMPTY
    end

    -- if there are tiles beneath, move forwards, otherwise fall
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) 
    	and self.y <= VIRTUAL_HEIGHT - (TILE_SIZE * 3) - self.height + 2 then
    	self.animation = 'walking'
    	self.x = self.x + self.dx * dt
    	self.dy = 1
    else
    	self.animation = 'falling'
    	self.dy = self.dy + self.gravity * dt
    	self.y = self.y + self.dy

    	-- GAME OVER
    	if self.y > VIRTUAL_HEIGHT then
            ATTEMPTS = ATTEMPTS + 1
	        gSounds['power_in']:play()
	        gStateMachine:change('play', {level = self.level})
    	end
    end

    -- if there is a brick to be spawned comming up, we activate the spell casting ability
    -- for a fraction of a second
    if tileBottomRight and tileBottomRight:prebrick() and tileBottomRight.is_first and not self.spell 
    	and self.animation == 'walking' then
    	self.spell = true
    	Timer.after(0.0625 / (BPM / 60), function () self.spell = false  end)
    end

end

function Player:render()
	if self.animation == 'falling' then
		if self.switch then
	        love.graphics.draw(gTextures['falling1'], math.floor(self.x), 
	        math.floor(self.y))
	    else
	        love.graphics.draw(gTextures['falling2'], math.floor(self.x), 
	        math.floor(self.y))
	    end

	elseif self.animation == 'walking' then
		if self.switch then
	        love.graphics.draw(gTextures['walking'], math.floor(self.x),
	        math.floor(self.y))
	    else
	        love.graphics.draw(gTextures['still'], math.floor(self.x), 
	        math.floor(self.y))
	    end
	end

end
