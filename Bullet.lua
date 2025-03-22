local Bullet = {}

Bullet.bullets = {}

function fly(bullet)
  if bullet.direction == "up" then
    bullet.y = bullet.y - bullet.speed
  end
end

function Bullet.makeBasicBullet(x, y, direction)
  bullet = {}
  bullet.kind = "fill"
  bullet.direction = direction
  bullet.x = x
  bullet.y = y
  bullet.speed = 10
  bullet.dmg = 25
  bullet.short = 10
  bullet.long = 25
  bullet.fly = fly
  return bullet
end

return Bullet