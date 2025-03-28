local Level = {}

local levels = {}

local startTime = 0

Level.Foes = {}

local FoeMaker = require("makeFoes")

local levelNum = 0

function Level.checkTimer()
  local levelTime = math.floor(love.timer.getTime() - startTime)
  local FoeTimeTable = currentLevel.onTime[levelTime]
  
  if FoeTimeTable ~= nil then
    for i, foe in pairs(FoeTimeTable) do
      if(type(foe) == 'function') and FoeTimeTable.fired == false then
        table.insert(Level.Foes, foe())
      end
    end
    FoeTimeTable.fired = true
    --FoeTimeTable.fired = true
  end
end

function Level.advance()
  -- Increment level number
  levelNum = levelNum + 1
  
  -- Load next level
  currentLevel = levels[levelNum]
  
  -- Reset level timer
  startTime = love.timer.getTime()

  -- Load starting foes
  for k, foe in pairs(currentLevel.onLoad) do
    table.insert(Level.Foes, foe())
  end
end

levels[1] = {
  onLoad = {
    function() return FoeMaker.makeBasicFoe(500, 0, 50, 50) end,
    function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
  },
  onTime = {
    
    [1] = {
      fired = false,
      function() return FoeMaker.makeBasicFoe(100, 50, 50, 50) end
    },
    [2] = {
      fired = false,
      function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end,
      function() return FoeMaker.makeBasicFoe(200, 600, 50, 50) end
    }
  }
}

levels[2] = {
  onLoad = {
    function() return FoeMaker.makeBasicFoe(500, 0, 50, 50) end,
    function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
  },
  onTime = {
    
    [1] = {
      fired = false,
      function() return FoeMaker.makeBasicFoe(100, 50, 50, 50) end,
      function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
    }
  }
}

return Level
