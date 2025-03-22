local playerMaker = {}
local Collision = require("collision")
local Bullet = require("Bullet")

function hitBy(hitter)
    if (hitter.cooldown < love.timer.getTime() - hitter.lastHit) then
      rect.hp = rect.hp - hitter.dmg
      hitter.lastHit = love.timer.getTime()
      Collision.handleKnockBack(player, hitter)
    else
      --handleSpaceExclusion(player, hitter)
    end
  end

function shoot(player)
  table.insert(Bullet.bullets, Bullet.makeBasicBullet(player.x + (player.w / 2), player.y + (player.h / 2), "up"))
end

function playerMaker.makePlayer(x, y, w, h)
  rect = {}
  rect.alive = true
  rect.hp = 100
  rect.maxHp = 100
  rect.speed = 125
  rect.kind = 'fill'
  rect.x = x
  rect.y = y
  rect.w = w
  rect.h = h
  rect.weapon = "basic"
  rect.shoot = shoot
  rect.hitBy = hitBy
  return rect
end

return playerMaker