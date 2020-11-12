--[[

    PROYECTO DE TITULO  
    Pamela Vilches Ivelic

    -- LevelMaker2 Class --

]]

LevelMaker2 = Class{}

function LevelMaker2.generate(width, height, level)
    local tiles = {}
    -- storing extra objects, such as signs or background jokes,
    local objects = {}

    local tileID = TILE_ID_GROUND
    
    -- whether we should draw our tiles with toppers
    local topper = true
    -- whether we are building a quiasm
    local chiasm = false
    -- posible brick sizes for the level
    local brick_sizes = {1, 2, 4}
    -- stores a random picked brick size when creating each quiasm
    local brick_size = 1
    -- stres a random picked module number when creating each quiasm
    local modules = 1
    -- stores the current platform size, starts at 16 to create the starting platform
    local platform = 20
    -- stores the level number so that each tile knows how to render it self accordingly
    local level = level
    -- distance between powers 
    local power_distance = 0
    -- counts the number of quiasms that have been created
    local quiasm_n = 0

    -- insert blank tables into tiles for later access
    for x = 1, height do
        table.insert(tiles, {})
    end

    -- column by column generation instead of row; sometimes better for platformers
    for x = 1, width do
        local tileID = TILE_ID_EMPTY
        power_distance = power_distance + 1
        
        -- lay out the empty space
        for y = 1, 6 do
            -- x > 16 so that we dont get a power in the start platform
            if y == 6 and math.fmod(x-1,4) == 0 and power_distance > 20 and x > 40 and level == 3 then
                random_number = math.random(1, 6)
                -- 1 in 3 chance to spawn a power, 1 for music off and 2 for bricks off
                if random_number == 1 then
                    table.insert(tiles[y],
                        Tile(x, y, TILE_ID_POWER_MUSIC_OFF, nil, true, level))
                    power_distance = 0
                elseif random_number == 2 then
                    table.insert(tiles[y],
                        Tile(x, y, TILE_ID_POWER_BRICKS_OFF, nil, true, level))
                    power_distance = 0
                else
                    table.insert(tiles[y],
                        Tile(x, y, tileID, nil, nil, level))

                end
            else
                table.insert(tiles[y],
                    Tile(x, y, tileID, nil, nil, level))
            end

        end

        -- Creates the first column in a quiasm, 
        if not platform and not chiasm then
            quiasm_n = quiasm_n + 1

            -- brick size can be 1, 2 or 4
            if quiasm_n < 4 then
                brick_size = 4
            elseif quiasm_n < 7 then
                brick_size = 2
            else
                brick_size = 1
            end

            modules = quiasm_n % 3

            if modules == 0 then
                modules = 3
            end

            -- we give the object the x and y coordenates of the start of the platform, and the brick size
            -- and module number
            table.insert(objects, Object((x - 1) * 16 - 64, 7 * 16, brick_size, modules))

            -- number of TILES that form a quiasm (not bricks)
            chiasm = modules * 4
            for y = 7, height do
                -- first tile (vertically) in the chiasm gets a block
                if y == 7 then
                    if brick_size == 1 then
                        tileID = TILE_ID_PREBRICK1
                    elseif brick_size == 2 then
                        tileID = TILE_ID_PREBRICK2
                    else
                        tileID = TILE_ID_PREBRICK3
                    end
                    -- first tile of a brick, so it gets a flag for rendering (fifth argument true)
                    table.insert(tiles[y],
                        Tile(x, y, tileID, nil, true, level))
                else
                    tileID = TILE_ID_EMPTY
                    table.insert(tiles[y],
                        Tile(x, y, tileID, nil, true, level))
                end
            end
            chiasm = chiasm - 1

        --if we are already making a chiasm lets keep building it
        elseif chiasm then
            for y = 7, height do
                -- first tile (vertically) in the chiasm gets a brick
                if y == 7 then
                    local is_first = nil

                    if brick_size == 1 then
                        tileID = TILE_ID_PREBRICK1
                    elseif brick_size == 2 then
                        tileID = TILE_ID_PREBRICK2
                    else
                        tileID = TILE_ID_PREBRICK3
                    end 

                    -- check to see if this is the first tile of a brick, so it gets a flag for rendering
                    if chiasm % brick_size == 0 then
                        is_first = true
                    end

                    table.insert(tiles[y],
                        Tile(x, y, tileID, nil, is_first, level))
                    is_first = nil
                else
                    tileID = TILE_ID_EMPTY
                    table.insert(tiles[y],
                        Tile(x, y, tileID, nil, true, level))
                end
            end
            chiasm = chiasm - 1
        -- regular ground tiles
        else
            tileID = TILE_ID_GROUND

            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, true, level))
            end
            platform = platform - 1

        end

        -- reset chiasm to false when finshed building it
        if chiasm == 0 then
            chiasm = false
            platform = 4
        end

        -- reset platform to false when finished building it
        if platform == 0 then
            platform = false
        end
    end
    
    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(objects, map)
end