local Bullet = {}

Bullet.bullets = {}

Bullet.lastShot = 0


function fly(bullet)
  if bullet.direction == "up" then
    bullet.y = bullet.y - bullet.speed
  end
end

function vanish(bullet)
  table.remove(Bullet.bullets, bullet)
end

function Bullet.makeBasicBullet(x, y, direction)
  bullet = {}
  bullet.kind = "fill"
  bullet.direction = direction
  bullet.x = x
  bullet.y = y
  bullet.speed = 10
  bullet.dmg = 5
  bullet.short = 10
  bullet.long = 25
  bullet.knockback = 0.1
  if(direction == "up" or direction == "down") then
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
