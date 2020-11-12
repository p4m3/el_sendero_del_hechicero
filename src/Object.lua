--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

-- Used to represent the fraction signs
Object = Class{}

function Object:init(x, y, brick_size, module_n)
    self.x = x + 32
    self.y = y - 32

    if brick_size == 1 then
        self.denom = 4
    elseif brick_size == 2 then
        self.denom = 2
    else
        self.denom = 1
    end

    self.num = module_n * self.denom
end

function Object:update(dt)
    -- Used to maybe animate the signs
end

function Object:render()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(self.num .. '/' .. self.denom, self.x, self.y)
end