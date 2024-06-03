function mainMenuUpdate(dt) 
    for i,v in ipairs(menuButtons) do
        checkButton(love.mouse.getX(),love.mouse.getY(),v)
    end
end

function gameUpdate(dt)
    if love.keyboard.isDown("escape") then
        scene = 3
    end

    time = time + dt

    for i,v in ipairs(balls) do
        v[2] = v[2] - v[3] * dt
        v[3] = v[3] - 1500 *dt
        v[1] = v[1] - 120 * v[4] * dt
        if v[2] > player.y + 50 then
            table.remove(balls,i)
        end
    end

    for i,v in ipairs(notes) do
        v[2] = v[2] - v[3] * dt
        if v[2] < 0 then
            table.remove(notes,i)
        end
    end

    playRhythm(usedRhythms,usedMoves)

    if player.animation == 0 then
        player.startTime = time
        player.animation = 5
        player.frame = 1
    end

    if noteTile.animation == 0 then
        noteTile.startTime = time
        noteTile.animation = 5
        noteTile.frame = 1
    end


    for i,object in ipairs(objects) do
        playAnimation(object)
    end
end

function pauseUpdate(dt)
    for i,v in ipairs(pauseButtons) do
        checkButton(love.mouse.getX(),love.mouse.getY(),v)
    end
end

function endScreenUpdate(dt)
    for i,v in ipairs(endButtons) do
        checkButton(love.mouse.getX(),love.mouse.getY(),v)
    end
end