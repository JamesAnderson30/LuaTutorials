
function love.load()
  currentLevel = 0
  nextLevel = 1
  
  foes = {}
  table.insert(foes, makeBasicFoe('line', 100, 10, 50, 0, 0, 50, 50, 200))
  
  levels = {}
  --level1 = 
  table.insert(levels, "Test")
  player = makePlayer(100, 125, 'fill', 300, 250, 50, 50)
end


function makeBasicFoe(kind, hp, dmg, speed, x, y, w, h, cooldown)
  rect = {}
  rect.kind = kind
  rect.hp = hp
  rect.dmg = dmg
  rect.speed = speed
  rect.x = x
  rect.y = y
  rect.w = w
  rect.h = h
  rect.lastHit = 0
  rect.cooldown = cooldown / 1000
  rect.ai = function(foe, player, dt)
      if(player.x - foe.x ~= 0) then
        foe.x = foe.x + ((player.x - foe.x) / math.abs(player.x - foe.x)) * foe.speed * dt
      end
      if (player.y - foe.y) then
        foe.y = foe.y + ((player.y - foe.y) / math.abs(player.y - foe.y)) * foe.speed * dt
      end
  end
  return rect
end

function makePlayer(hp,speed,kind, x, y, w, h)
  rect = {}
  rect.alive = true
  rect.hp = hp
  rect.speed = speed
  rect.kind = kind
  rect.x = x
  rect.y = y
  rect.w = w
  rect.h = h
  rect.hitBy = function(hitter)
    print(love.timer.getTime() - hitter.lastHit)
    if (hitter.cooldown < love.timer.getTime() - hitter.lastHit) then
      rect.hp = rect.hp - hitter.dmg
      hitter.lastHit = love.timer.getTime()
    end
  end
  return rect
end

function drawRect(rect)
  love.graphics.rectangle(rect.kind, rect.x, rect.y, rect.w, rect.h)
end

function CheckCollision(thing1, thing2)
  return thing1.x < thing2.x + thing2.w and
         thing2.x < thing1.x + thing1.w and
         thing1.y < thing2.y + thing2.h and
         thing2.y < thing1.y + thing1.h
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
    foe.ai(foe, player, dt)
    
  end
  --
  
  --
  
  -- CHECK COLLISON
  for i, foe in ipairs(foes) do
    if CheckCollision(foe, player) then
      player.hitBy(foe)
      if player.hp <= 0 then
        player.alive = false
      end
    end
  end
  
end



-------------------



function love.draw()
  --DRAW FOES
  for i,v in ipairs(foes) do
    love.graphics.rectangle(v.kind, v.x, v.y, v.w, v.h)
  end
  --END DRAW FOES
  
  --
  
  --DRAW PLAYER  
  if player.alive == true then
    drawRect(player)
    love.graphics.print(player.hp)
  else
    love.graphics.print("DEAD")
  end
  --END DRAW PLAYERa
  
  
end
