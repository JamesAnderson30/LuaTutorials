local Bullet = {}

Bullet.bullets = {}

Bullet.lastShot = 0


function fly(bullet)
  if bullet.direction == "up" then
    bullet.y = bullet.y - bullet.speed
  end
  
  if bullet.direction == "down" then
    bullet.y = bullet.y + bullet.speed
  end
  
  if bullet.direction == "right" then
    bullet.x = bullet.x + bullet.speed
  end
  
  if bullet.direction == "left" then
    bullet.x = bullet.x - bullet.speed
  end
end

function vanish(bulletId)
  table.remove(Bullet.bullets, bulletId)
end

local function draw(bullet)
  love.graphics.rectangle(bullet.kind, bullet.x, bullet.y, bullet.w, bullet.h)
end

function Bullet.makeBasicBullet(x, y, direction)
  bullet = {}
  bullet.kind = "fill"
  bullet.direction = direction
  bullet.x = x
  bullet.y = y
  bullet.speed = 10
  bullet.dmg = 20
  bullet.short = 10
  bullet.long = 25
  bullet.knockback = 0.1
  bullet.draw = draw
  if(bullet.direction == "up" or bullet.direction == "down") then
    bullet.w = bullet.short
    bullet.h = bullet.long
  else 
    bullet.w = bullet.long
    bullet.h = bullet.short
  end
  bullet.fly = fly
  bullet.vanish = vanish
  return bullet
end

return Bullet
