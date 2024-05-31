--Collects files within an animation folder into an array of images
function generateAnimation(animation,length)
    table.insert(animations,{})
    for i,v in ipairs(love.filesystem.getDirectoryItems(animation)) do
        table.insert(animations[#animations],love.graphics.newImage(animation .. v))
    end
    table.insert(animations[#animations],length)
end

--Checks if enough time has passed to update the animation
--Then updates the animation
function playAnimation(object)
    if object.animation > 0 then
        animationLength = animations[object.animation][#animations[object.animation]]
        animationFrames = (#animations[object.animation]-1)
        if time - object.startTime >= (animationLength / animationFrames) * object.frame then
            object.frame = object.frame + 1
            if (object.frame > animationFrames) then
                object.animation = 0
                object.frame = 1
            end
        end
    end
end

--Draws the animation to the screen
function drawAnimation(object) 
    if object.animation > 0 then
        frameToDraw = animations[object.animation][object.frame]
    else 
        if object.still > 0 then
            frameToDraw = sprites[object.still]
        end
    end
    if object.animation > 0 or object.still > 0 then
        xScale = object.dir * object.sx / frameToDraw:getWidth()
        yScale = object.sy / frameToDraw:getHeight()
        xPos = object.x
        if object.dir == -1 then
            xPos = xPos + object.sx
        end
        if object.animation == 6 then
            xScale = xScale * 2
            xPos = xPos - object.sx/2
            if object.dir == -1 then
                xPos = xPos + object.sx
            end
        end
        love.graphics.draw(frameToDraw,xPos,object.y,0,xScale,yScale)
    end
end