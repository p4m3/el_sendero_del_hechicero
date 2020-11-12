--[[
    PROYECTO DE TITULO
    Pamela Vilches Ivelic
]]

--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'
require 'src/states/IntroState'
require 'src/states/TutorialState'

-- general
require 'src/LevelMaker'
require 'src/LevelMaker2'
require 'src/Tile'
require 'src/TileMap'
require 'src/GameLevel'
require 'src/Player'
require 'src/Object'



gSounds = {
	['song1'] = love.audio.newSource('sounds/pachelbels_canon.wav'),
	['song3'] = love.audio.newSource('sounds/queen_of_the_night.mp3'),
	['song2'] = love.audio.newSource('sounds/hungarian_dance.wav'),
	['metronome'] = love.audio.newSource('sounds/metronome.wav'),
	['hihat'] = love.audio.newSource('sounds/hihat.wav'),
	['guitar'] = love.audio.newSource('sounds/guitar.wav'),
	['punch'] = love.audio.newSource('sounds/punch.wav'),
	['start'] = love.audio.newSource('sounds/start.wav'),
	['pause'] = love.audio.newSource('sounds/pause.wav'),
	['power_in'] = love.audio.newSource('sounds/power_in2.wav'),
	['power_out'] = love.audio.newSource('sounds/power_out.wav'),
	['intro'] = love.audio.newSource('sounds/summer_vivaldi.mp3'),
}

gTextures = {
	['tile1'] = love.graphics.newImage('graphics/tile1.png'),
	['tile2'] = love.graphics.newImage('graphics/tile2.png'),
	['topper0'] = love.graphics.newImage('graphics/topper0.png'),
	['topper1'] = love.graphics.newImage('graphics/topper1.png'),
	['topper2'] = love.graphics.newImage('graphics/topper2.png'),
	['topper3'] = love.graphics.newImage('graphics/topper3.png'),
	['empty_tile'] = love.graphics.newImage('graphics/empty_tile.png'),
	['background1a'] = love.graphics.newImage('graphics/background1a.png'),
	['background1b'] = love.graphics.newImage('graphics/background1b.png'),
	['background1c'] = love.graphics.newImage('graphics/background1c.png'),
	['background2a'] = love.graphics.newImage('graphics/background2a.png'),
	['background2b'] = love.graphics.newImage('graphics/background2b.png'),
	['background2c'] = love.graphics.newImage('graphics/background2c.png'),
	['background3a'] = love.graphics.newImage('graphics/background3a.png'),
	['background3b'] = love.graphics.newImage('graphics/background3b.png'),
	['background3c'] = love.graphics.newImage('graphics/background3c.png'),
	['still'] = love.graphics.newImage('graphics/character_still.png'),
	['walking'] = love.graphics.newImage('graphics/character_walking.png'),
	['falling1'] = love.graphics.newImage('graphics/falling1.png'),
	['falling2'] = love.graphics.newImage('graphics/falling2.png'),
	['brick1'] = love.graphics.newImage('graphics/brick1.png'),
	['brick2'] = love.graphics.newImage('graphics/brick2.png'),
	['brick3'] = love.graphics.newImage('graphics/brick3.png'),
	['empty_brick1'] = love.graphics.newImage('graphics/empty_brick1.png'),
	['empty_brick2'] = love.graphics.newImage('graphics/empty_brick2.png'),
	['empty_brick3'] = love.graphics.newImage('graphics/empty_brick3.png'),
	['particle'] = love.graphics.newImage('graphics/particle.png'),
	['power'] = love.graphics.newImage('graphics/power.png'),
	['power2'] = love.graphics.newImage('graphics/power2.png'),
	['cover'] = love.graphics.newImage('graphics/cover.png'),
	['tutorial1'] = love.graphics.newImage('graphics/tutorial1.png'),
	['tutorial2'] = love.graphics.newImage('graphics/tutorial2.png'),
	[1] = love.graphics.newImage('graphics/introStyleBoards1.png'),
	[2] = love.graphics.newImage('graphics/introStyleBoards2.png'),
	[3] = love.graphics.newImage('graphics/introStyleBoards3.png'),
	[4] = love.graphics.newImage('graphics/introStyleBoards4.png'),
	[5] = love.graphics.newImage('graphics/introStyleBoards5.png'),
	[6] = love.graphics.newImage('graphics/introStyleBoards6.png'),
	[7] = love.graphics.newImage('graphics/introStyleBoards7.png')
}

gFrames = {

}

gFonts = {
	['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}