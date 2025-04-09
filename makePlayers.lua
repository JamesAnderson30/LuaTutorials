local playerMaker = {}
local Collision = require("collision")
local Bullet = require("Bullet")


function hitBy(hitter)
    if (hitter.cooldown < love.timer.getTime() - hitter.lastHit) then
      player.hp = player.hp - hitter.dmg
      hitter.lastHit = love.timer.getTime()
      Collision.handleKnockBack(player, hitter)
    else
      --handleSpaceExclusion(player, hitter)
    end
  end


local function shoot(player)
  --Check Cooldown
  local bulletX = 0
  local bulletY = 0
  if(player.cooldown < love.timer.getTime() - player.lastShot) then
    if player.direction == "up" then
      bulletX = player.x + (player.w / 2) - (faceW / 2)
      bulletY = player.y
    end
    
    if player.direction == "down" then
      bulletX = player.x + (player.w / 2) - (faceW / 2)
      bulletY = player.y + player.h - FL
    end
    
    if player.direction == "left" then
      bulletX = player.x
      bulletY = player.y + (player.h / 2) - (faceH / 2)
    end
    
    if player.direction == "right" then
      bulletX = player.x + player.w - FL
      bulletY = player.y + (player.h / 2) - (faceH / 2)
    end
    
      table.insert(Bullet.bullets, Bullet.makeBasicBullet(bulletX, bulletY, player.direction))
      player.lastShot = love.timer.getTime()
  end
end

local function draw(player)
  love.graphics.rectangle(player.kind, player.x, player.y, player.w, player.h)
  
  -- "Face Short"
  FS = 7
  
  -- "Face Long"
  FL = 15
  
  love.graphics.setColor(255,0,0) --Red
  if player.direction == "up" then
    faceW = FS
    faceH = FL
    faceX = player.x + (player.w / 2) - (faceW / 2)
    faceY = player.y
  end
  
  if player.direction == "down" then
    faceX = player.x + (player.w / 2) - (faceW / 2)
    faceY = player.y + player.h - FL
    faceW = FS
    faceH = FL
  end
  
  if player.direction == "left" then
    faceX = player.x
    faceY = player.y + (player.h / 2) - (faceH / 2)
    faceW = FL
    faceH = FS
  end
  
  if player.direction == "right" then
    faceX = player.x + player.w - FL
    faceY = player.y + (player.h / 2) - (faceH / 2)
    faceW = FL
    faceH = FS
  end
  
  love.graphics.rectangle("line", faceX, faceY, faceW, faceH)
  
  love.graphics.setColor(255,255,255) --Red
end

function playerMaker.makePlayer(x, y, w, h)
  player = {}
  player.alive = true
  player.hp = 100
  player.maxHp = 100
  player.speed = 125
  player.kind = 'fill'
  player.direction = "up"
  player.x = x
  player.y = y
  player.w = w
  player.h = h
  player.weapon = "basic"
  player.shoot = shoot
  player.draw = draw
  player.lastShot = 0
  player.cooldown = 200 / 1000 -- divide by a thousand to measure in milliseconds, my preference
  player.hitBy = hitBy
  return player
end

return playerMaker
