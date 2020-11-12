--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

-- size of actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size emulated with push
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

-- global standard tile size
TILE_SIZE = 16

-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

-- Beats per minute, this number controls the speed of every rythm based element in the game
BPM = 56.5

-- Counts the number of times the level has been attempted by the user
ATTEMPTS = 1


-- tile id for the ground type tile
TILE_ID_GROUND = 1
TILE_ID_EMPTY = 2
TILE_ID_BRICK1 = 3
TILE_ID_BRICK2 = 4
TILE_ID_BRICK3 = 5
TILE_ID_PREBRICK1 = 6
TILE_ID_PREBRICK2 = 7
TILE_ID_PREBRICK3 = 8
TILE_ID_POWER_MUSIC_OFF = 9
TILE_ID_POWER_BRICKS_OFF = 10

-- table of tiles that should trigger a collision
COLLIDABLE_TILES = {
    TILE_ID_GROUND,
    TILE_ID_BRICK1,
    TILE_ID_BRICK2,
    TILE_ID_BRICK3,
}

-- table of tiles that can become bricks
PRE_BRICKS = {
    TILE_ID_PREBRICK1,
    TILE_ID_PREBRICK2,
    TILE_ID_PREBRICK3,
}

-- power ups or downs controllers
POWER_DOWN_NO_BRICKS = false
