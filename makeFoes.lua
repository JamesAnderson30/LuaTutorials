Level = Level or require("Level")
local foeMakers = {makeBasicFoe}

local function basicAi(foe, player, dt)
    if(player.x - foe.x ~= 0) then
      foe.x = foe.x + ((player.x - foe.x) / math.abs(player.x - foe.x)) * foe.speed * dt
      foe.hpX = (foe.x + (foe.w / 2))
    end
    if (player.y - foe.y) then
      foe.y = foe.y + ((player.y - foe.y) / math.abs(player.y - foe.y)) * foe.speed * dt
      foe.hpY = (foe.y + (foe.h / 2))
    end
  end
  
local function handleBeingShot(foe, bullet)
  foe.hp = foe.hp - bullet.dmg
  if foe.hp <= 0 then
    foe.isAlive = false
    Level.defeated = Level.defeated + 1    
  end
end

local function draw(v)
  love.graphics.rectangle(v.kind, v.x, v.y, v.w, v.h)
  love.graphics.print(v.hp, v.hpX, v.hpY)
end

function foeMakers.makeBasicFoe(x, y, w, h)
  foe = {}
  foe.kind = 'line'
  foe.hp = 100
  foe.isAlive = true
  foe.dmg = 10
  foe.speed = 50
  foe.x = x
  foe.y = y
  foe.w = w
  foe.h = h
  -- HP tag location
  foe.hpX = (x + (w / 2))
  foe.hpY = (y + (h / 2))
  foe.lastHit = 0
  foe.cooldown = 200 / 1000
  foe.knockback = 0.5
  foe.isColliding = false
  foe.handleBeingShot = handleBeingShot
  foe.ai = basicAi
  foe.draw = draw
  return foe
end

function foeMakers.makeFastFoe(x, y, w, h)
  foe = {}
  foe.kind = 'line'
  foe.hp = 60
  foe.isAlive = true
  foe.dmg = 15
  foe.speed = 90
  foe.x = x
  foe.y = y
  foe.w = w
  foe.h = h
  -- HP tag location
  foe.hpX = (x + (w / 2))
  foe.hpY = (y + (h / 2))
  foe.lastHit = 0
  foe.cooldown = 100 / 1000
  foe.knockback = 0.5
  foe.isColliding = false
  foe.handleBeingShot = handleBeingShot
  foe.ai = basicAi
  foe.draw = draw
  return foe
end



return foeMakers

