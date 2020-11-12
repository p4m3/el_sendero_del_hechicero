--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

Tile = Class{}

function Tile:init(x, y, id, topper, is_first, level)
    self.x = x
    self.y = y

    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.id = id
    self.topper = topper
    self.is_first = is_first
    self.level = level
end

--[[
    Checks to see whether this ID is whitelisted as collidable in a global constants table.
]]
function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

--[[
    Checks to see whether this ID is whitelisted as prebrick in a global constants table.
]]
function Tile:prebrick(target)
    for k, v in pairs(PRE_BRICKS) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    if POWER_DOWN_NO_BRICKS and (self.id == TILE_ID_BRICK1 or self.id == TILE_ID_BRICK2 or
        self.id == TILE_ID_BRICK3)then
        love.graphics.draw(gTextures['empty_tile'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
        return
    end


    if self.id == TILE_ID_EMPTY or not self.is_first then
        love.graphics.draw(gTextures['empty_tile'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    elseif self.id == TILE_ID_BRICK1 and self.is_first then
        love.graphics.draw(gTextures['brick1'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    elseif self.id == TILE_ID_BRICK2 and self.is_first then
        love.graphics.draw(gTextures['brick2'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    elseif self.id == TILE_ID_BRICK3 and self.is_first then
        love.graphics.draw(gTextures['brick3'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    elseif self.id == TILE_ID_PREBRICK1 and self.is_first then
        if self.level == 1 or self.level == 0 then
            love.graphics.draw(gTextures['empty_brick1'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
        end
    elseif self.id == TILE_ID_PREBRICK2 and self.is_first then
        if self.level == 1 or self.level == 0 then
            love.graphics.draw(gTextures['empty_brick2'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
        end
    elseif self.id == TILE_ID_PREBRICK3 and self.is_first then
        if self.level == 1 or self.level == 0 then
            love.graphics.draw(gTextures['empty_brick3'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
        end
    elseif self.id == TILE_ID_POWER_MUSIC_OFF then
        love.graphics.draw(gTextures['power'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    elseif self.id == TILE_ID_POWER_BRICKS_OFF then
        love.graphics.draw(gTextures['power2'],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    else
        if self.level == 0 then
            love.graphics.draw(gTextures['empty_tile'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            if self.topper then
                love.graphics.draw(gTextures['topper0'],
                    (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            end
        elseif self.level == 1 then
            love.graphics.draw(gTextures['tile1'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            if self.topper then
                love.graphics.draw(gTextures['topper1'],
                    (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            end
        elseif self.level == 2 then
            love.graphics.draw(gTextures['tile2'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            if self.topper then
                love.graphics.draw(gTextures['topper2'],
                    (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            end
        else
            love.graphics.draw(gTextures['empty_tile'],
                (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            if self.topper then
                love.graphics.draw(gTextures['topper3'],
                    (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
            end
        end
    end


end