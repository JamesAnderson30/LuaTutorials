local Level = {}

local levels = {}

local startTime = 0

local delayTime = 5

Level.defeated = 0

Level.Foes = {}

Level.foeCount = 0

Level.inTransition = 0

Level.levelNum = 0

--  LOAD LEVEL (no transition)
function Level.start(level)
  Level.levelNum = level
  
  -- Load next level
  currentLevel = levels[Level.levelNum]
  
  -- Reset level timer
  Level.startTime = love.timer.getTime()
  
  Level.defeated = 0
  
  -- Load starting foes
  for k, foe in pairs(currentLevel.onLoad) do
    Level.addFoe(foe)
  end
end

-- Handle Transitions

  


-- TRACK FOES

function Level.addFoe(foe)
  if type(foe) == 'table' then
    table.insert(Level.Foes, foe)
  else
    table.insert(Level.Foes, foe())
  end
  Level.foeCount = Level.foeCount + 1
end
  
function Level.removeFoe(foe)
  Level.foeCount = Level.foeCount - 1
  Level.defeated = Level.defeated + 1
end

-- CHECK SPAWN TIMER

function Level.checkTimer()
  printMe1 = Level.foeCount
  local levelTime = math.floor(love.timer.getTime() - Level.startTime)
  local FoeTimeTable = currentLevel.onTime[levelTime]
  
  if FoeTimeTable ~= nil then
    for i, foe in pairs(FoeTimeTable) do
      if(type(foe) == 'function') and FoeTimeTable.fired == false then
        Level.addFoe(foe)
      end
    end
    FoeTimeTable.fired = true
    --FoeTimeTable.fired = true
  end
end

-- CHECK EVENTS

function Level.checkEvents()
  for k, event in pairs(currentLevel.events) do
    --printMe4 = tostring(event.func())
    if event.func(event.triggered) then
      event.triggered = true
    end
  end
end

-- CHECK AND HANDLE LEVEL COMPLETION
function Level.checkLevelCompletion()
  if(currentLevel.maxSpawnTime < love.timer.getTime() - Level.startTime 
    and Level.foeCount <= 0 
    and Level.defeated >= currentLevel.defeatedGoal) 
  then
    Level.advance()
  end
end

function Level.advance()
  -- Increment level number
  
  Level.levelNum = Level.levelNum + 1
  
  -- Load next level
  currentLevel = levels[Level.levelNum]
  
  -- Reset level timer
  Level.startTime = love.timer.getTime() + delayTime
  
  Level.defeated = 0
  
  printMe2 = Level.levelNum
  -- Execute level transition
  Level.inTransition = true

  -- Load starting foes
  for k, foe in pairs(currentLevel.onLoad) do
    Level.addFoe(foe)
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
  maxSpawnTime = 4,
  defeatedGoal = 5,
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
          Level.addFoe(FoeMaker.makeBasicFoe(600, 0, 50, 50))
          return true
        else
          return false
        end        
      end
    }
  }
}

levels[2] = {
  --Make sure to set maxSpawnTime to the latest timed spawn
  --Make sure to set defeated goal
  maxSpawnTime = 4,
  defeatedGoal = 5,
  onLoad = {
    function() return FoeMaker.makeBasicFoe(500, 0, 50, 50) end,
    function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
  },
  onTime = {
    
    [1] = {
      fired = false,
      function() return FoeMaker.makeFastFoe(100, 50, 50, 50) end,
    },
    [2] = {
      fired = false,
      function() return FoeMaker.makeFastFoe(600, 100, 50, 50) end,
    },
    [3] = {
      fired = false,
      function() return FoeMaker.makeFastFoe(200, 300, 25, 25) end,
    },
    [4] = {
      function() return FoeMaker.makeBasicFoe(500, 0, 50, 50) end,
      function() return FoeMaker.makeBasicFoe(200, 500, 50, 50) end
    }
  },
  events = {
    ["whenDefeated"] = {
      triggered = false, 
      func = function(triggered) 
        if(Level.defeated > 1 and triggered == false) then
          table.insert(Level.Foes, FoeMaker.makeFastFoe(600, 0, 50, 50))
          return true
        else
          return false
        end        
      end
    }
  }
}

return Level
