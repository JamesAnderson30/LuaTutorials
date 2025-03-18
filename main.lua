
function love.load()
  currentLevel = 0
  nextLevel = 1
  
  foes = {}
  table.insert(foes, makeFoe('line', 100, 10, 100, 0, 0, 100, 100))
  
  levels = {}
  --level1 = 
  table.insert(levels, "Test")
  player = makePlayer(125, 'fill', 300, 250, 200, 100)
end


function makeFoe(kind, hp, dmg, speed, x, y, w, h)
  rect = {}
  rect.kind = kind
  rect.hp = hp
  rect.dmg = dmg
  rect.speed = speed
  rect.x = x
  rect.y = y
  rect.w = w
  rect.h = h
  return rect
end

function makePlayer(speed,kind, x, y, w, h)
  rect = {}
  rect.speed = speed
  rect.kind = kind
  rect.x = x
  rect.y = y
  rect.w = w
  rect.h = h
  return rect
end

function drawRect(rect)
  love.graphics.rectangle(rect.kind, rect.x, rect.y, rect.w, rect.h)
end



function love.update(dt)
  -- CHECK IF NEW LEVEL

  -- END NEW LEVEL
  
  --
  
  -- PLAYER CONTROLS
  if love.keyboard.isDown('w') then
    player.y = player.y - player.speed * dt
  end
  
  if love.keyboard.isDown('s') then
    player.y = player.y + player.speed * dt
  end
  
  if love.keyboard.isDown('a') then
    player.x = player.x - player.speed * dt
  end
  
  if love.keyboard.isDown('d') then
    player.x = player.x + player.speed * dt
  end
  -- END PLAYER CONTROLS
  
  --
  
  -- FOE AI
  for i, foe in ipairs(foes) do
    print((player.x - foe.x) / math.abs(player.x - foe.x))
    foe.x = foe.x + ((player.x - foe.x) / math.abs(player.x - foe.x)) * foe.speed * dt
    foe.y = foe.y + ((player.y - foe.y) / math.abs(player.y - foe.y)) * foe.speed * dt
  end
end

function love.draw()
  --DRAW FOES
  for i,v in ipairs(foes) do
    love.graphics.rectangle(v.kind, v.x, v.y, v.w, v.h)
  end
  --END DRAW FOES
  
  --
  
  --DRAW PLAYER  
  drawRect(player)
  --END DRAW PLAYERa
end


