local Level = {}

local levels = {}

Level.Foes = {}

local FoeMaker = require("makeFoes")

local levelNum = 0



function Level.advance()
  levelNum = levelNum + 1
  currentLevel = levels[levelNum]
  for k, foe in pairs(currentLevel.onLoad) do
    table.insert(Level.Foes, foe())
  end
end

levels[1] = {
  onLoad = {
    function() return FoeMaker.makeBasicFoe(500, 0, 50, 50) end,
    function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
  }
}

return Level
