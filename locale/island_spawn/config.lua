---- start config ----

--[[
SCENARIO_NAME = "Island Spawn"
AUTHOR = "BinarySpike"
--]]

-- Width of empty space between ores
TRACK_WIDTH = 4

-- Size of initial-ore (only used to calculate SPAWN_SIZE)
ORE_SIZE = 8

-- Size of spawn zone.
SPAWN_SIZE = TRACK_WIDTH+1 + ORE_SIZE

-- Starting value of ore
INITIAL_ORE_VALUE = 160

-- Do you start the game with Landfill researched? (Useful if ORE_SIZE and INITIAL_ORE_VALUE are low)
START_WITH_LANDFILL_RESEARCHED = true

-- Chance (percent) that an island will spawn
ISLAND_SPAWN_CHANCE = 5 -- 5%

-- Debug mode gives you a ton of landfill starting out
DEBUG = false

-- This function calculates the cost of a tile based on it's position from the center of the map

function costCalc(x, y)
    -- return INITIAL_ORE_VALUE + math.sqrt(((math.abs(x) + math.abs(y))^2)/20)
    -- simpler version
    return INITIAL_ORE_VALUE + ((math.abs(x)+math.abs(y)) / 5)
end


-- This table defines 
