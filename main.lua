

function love.load()
  
end

x = 100
y = 100
moveSpeed = 50

function love.update(dt)
  if love.keyboard.isDown("w") then
    y = y - moveSpeed * dt
  end
  
  if love.keyboard.isDown("s") then
    y = y + moveSpeed * dt
  end
  
  if love.keyboard.isDown("d") then
    x = x + moveSpeed * dt
  end
  
  if love.keyboard.isDown("a") then
    x = x - moveSpeed *dt
  end
end

function love.draw()
  love.graphics.rectangle("line", x, y, 200, 150)
end



