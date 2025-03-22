local foeMakers = {makeBasicFoe}

function basicAi(foe, player, dt)
    if(player.x - foe.x ~= 0) then
      foe.x = foe.x + ((player.x - foe.x) / math.abs(player.x - foe.x)) * foe.speed * dt
    end
    if (player.y - foe.y) then
      foe.y = foe.y + ((player.y - foe.y) / math.abs(player.y - foe.y)) * foe.speed * dt
    end
  end

function foeMakers.makeBasicFoe(x, y, w, h)
  foe = {}
  foe.kind = 'line'
  foe.hp = 100
  foe.dmg = 10
  foe.speed = 50
  foe.x = x
  foe.y = y
  foe.w = w
  foe.h = h
  foe.lastHit = 0
  foe.cooldown = 200 / 1000
  foe.knockback = 0.5
  foe.isColliding = false
  foe.ai = basicAi
  return foe
end



return foeMakers

