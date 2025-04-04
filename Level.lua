local Level = {}

local levels = {}

local startTime = 0

Level.defeated = 0

Level.Foes = {}



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

function Level.checkEvents()
  for k, event in pairs(currentLevel.events) do
    --printMe4 = tostring(event.func())
    if event.func(event.triggered) then
      event.triggered = true
    end
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

-- HOW LEVEL SPAWNING WORKS
-- There are three options to spawn foes on levels:
-- onLoad, a list of functions that will execute immediately and only once to spawn foes. Just return the foe you want to make
--
-- onTime, a list of functions that will execute when a certain time has passed. The table index of onTime repersents the 'second' that you want the list of functions to execute. Each function should return the foe you want to spawn
--
-- onEvents, a list of functions that will execute every other frame. each event must have a parameter called 'triggered' to work properly, each even must also have a 'func' parameter. This is what will fire. You may test conditions and spawn enemies. When you want the event to stop triggering, return 'true'. If you do not return 'true' the event will trigger endlessly. That said, if you want the event to keep firing, return 'false'

levels[1] = {
  onLoad = {
    function() return FoeMaker.makeBasicFoe(500, 0, 50, 50) end,
    function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
  },
  onTime = {
    
    [3] = {
      fired = false,
      function() return FoeMaker.makeBasicFoe(100, 50, 50, 50) end
    },
    [5] = {
      fired = false,
      function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end,
      function() return FoeMaker.makeBasicFoe(200, 600, 50, 50) end
    }
  },
  events = {
    --Test Event
    ["whenDefeated"] = {
      triggered = false, 
      func = function(triggered) 
        if(Level.defeated > 2 and triggered == false) then
          table.insert(Level.Foes, FoeMaker.makeBasicFoe(600, 0, 50, 50))
          return true
        else
          return false
        end        
      end
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
