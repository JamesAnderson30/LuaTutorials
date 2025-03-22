local Collisions = {}

function Collisions.CheckCollision(thing1, thing2)
  return thing1.x < thing2.x + thing2.w and
         thing2.x < thing1.x + thing1.w and
         thing1.y < thing2.y + thing2.h and
         thing2.y < thing1.y + thing1.h
end

function Collisions.handleKnockBack(target, hitter)
  left = (target.x + target.w) - hitter.x
  right = (hitter.x + hitter.w) - target.x
  top = (target.y + target.h) - hitter.y
  bottom = (hitter.y + hitter.h) - target.y
  
  -- If target is hit in the right
  if left < right and left < top and left < bottom then
    target.x = target.x - (target.w * hitter.knockback)
  end
  -- If target is hit in the left
  if right < left and right < top and right < bottom then
    target.x = target.x + (target.w * hitter.knockback)
  end
  -- If target is hit on the bottom
  if top < left and top < right and top < bottom then
    target.y = target.y - (target.h * hitter.knockback)
  end
  -- If target is hit on the top
  if bottom < left and bottom < right and bottom < top then
    target.y = target.y + (target.h * hitter.knockback)
  end
end

return Collisions