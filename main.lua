
-- Debuggers :)
printMe1 = "nothing"
printMe2 = "nothing"
printMe3 = "nothing"
printMe4 = "nothing"

FoeMaker = require("makeFoes")
PlayerMaker = require("makePlayers")
Collision = require("Collision")
Level = require("Level")
Bullet = require("Bullet")

local tickCount = 0


function love.load()
  Level.advance()
  player = PlayerMaker.makePlayer(300, 250, 50, 50)
end

function drawRect(rect)
  love.graphics.rectangle(rect.kind, rect.x, rect.y, rect.w, rect.h)
end




function love.update(dt)
  tickCount = tickCount + 1
  -- CHECK IF NEW LEVEL

  -- END NEW LEVEL
  
  --
  
  -- CHECK LEVEL TIMER
  Level.checkTimer()
  
  --
  -- CHECK LEVEL EVENTS every other frame

  if tickCount % 2 == 1 then
    Level.checkEvents()
  end
  
  -- PLAYER CONTROLS
  if player.alive then
    if love.keyboard.isDown("space") then
      player.shoot(player)
    end 
    
    if love.keyboard.isDown('w') then
      player.y = player.y - player.speed * dt
      player.direction = "up"
    end
    
    if love.keyboard.isDown('s') then
      player.y = player.y + player.speed * dt
      player.direction = "down"
    end
    
    if love.keyboard.isDown('a') then
      player.x = player.x - player.speed * dt
      player.direction = "left"
    end
    
    if love.keyboard.isDown('d') then
      player.x = player.x + player.speed * dt
      player.direction = "right"
    end
    
    function love.keypressed(key, scancode, isrepeat)
      if key == "p" then
        Level.advance()
      end
    end
  end
  -- END PLAYER CONTROLS
  
  --
  
  -- FOE AI
  for i, foe in ipairs(Level.Foes) do
    if foe.isColliding == false then
      foe.ai(foe, player, dt)
    end
  end
  --
  
  --
  
  -- BULLET AI
  for i, bullet in ipairs(Bullet.bullets) do
    bullet.fly(bullet)
  end
  --
  
  -- CHECK FOE AGAINST PLAYER COLLISON
  for i, foe in ipairs(Level.Foes) do
    if Collision.CheckCollision(foe, player) then
      foe.isColliding = true
      if player.alive == true then
        player.hitBy(foe)
      end
      if player.hp <= 0 then
        player.alive = false
      end
    else
      foe.isColliding = false
    end
  end
  
  ----
  
  -- CHECK FOE ON FOE COLLISION
  
  ---
  
  -- CHECK FOE ON BULLET COLLISON
  
  for i, foe in ipairs(Level.Foes) do
    for k, bullet in ipairs(Bullet.bullets) do
      if Collision.CheckCollision(foe, bullet) then
        foe.handleBeingShot(foe, bullet)
        Collision.handleKnockBack(foe, bullet)
        bullet.vanish(k)
        if foe.isAlive == false then
          table.remove(Level.Foes, i)
        end
      end
    end
  end
  
  -- CHECK LEVEL COMPLETION
  Level.checkLevelCompletion()
  
end

-------------------



function love.draw()
  -- For debugging :)
  love.graphics.print(printMe1, 50)
  love.graphics.print(printMe2, 50, 25)
  love.graphics.print(printMe3, 50, 50)
  love.graphics.print(printMe4, 50, 75)
  --DRAW FOES
  for i,v in ipairs(Level.Foes) do
    v.draw(v)
    --love.graphics.rectangle(v.kind, v.x, v.y, v.w, v.h)
  end
  --END DRAW FOES
  
  --
  
  --DRAW PLAYER  
  if player.alive == true then
    player.draw(player)
    love.graphics.print(player.hp)
  else
    love.graphics.print("DEAD")
  end
  --END DRAW PLAYERa
  
  --
  
  --DRAW BULLETS
  for i,bullet in ipairs(Bullet.bullets) do
    --love.graphics.rectangle(v.kind, v.x, v.y, v.short, v.long)
    bullet.draw(bullet)
    
  end
  
  
end
