function startRhythm (rhythm,wait)
    if playedRhythm == 0 then
        playerInput = 0
        playedRhythm = rhythm
        rhythmStart = time + wait
        rhythmIndex = 1
        firstNote = 0
        counting = 1
        if allowCounting == 1 then
            countDown.animation = 3
            countDown.startTime = time
            countDown.frame = 1
            allowCounting = 0
        end
    end
end

function playRhythm ()
    if sizeBoost == 1 and time > sizeTime + .05 then
        sizeBoost = 0
        player.sx = player.sx - sizeIncrease
        player.sy = player.sy - sizeIncrease
        player.x = player.x + sizeIncrease/2
        player.y = player.y + sizeIncrease/2
    end
    if counting == 0 then
        if playedRhythm > 0 then
            if firstNote == 0 then
                firstNote = 1
                noteTile.animation = 2
                noteTile.startTime = time
                noteTile.frame = 1
                love.audio.stop(note)
                love.audio.play(note)
            end
            if time - rhythmStart >= rhythms[playedRhythm][rhythmIndex] then
                noteTile.animation = 2
                noteTile.startTime = time
                noteTile.frame = 1
                love.audio.stop(note)
                love.audio.play(note)
                rhythmStart = rhythmStart + rhythms[playedRhythm][rhythmIndex]
                rhythmIndex = rhythmIndex + 1
                if rhythmIndex > #rhythms[playedRhythm] - 1 then
                    playerInput = 1
                    hits = 0
                    hitScore = 0
                    playerIndex = 0
                    playerRhythm = playedRhythm
                    playedRhythm = 0
                    rhythmStart = time
                    -- Play King AnimTION
                    --startRhythm(math.random(#rhythms),3)
                end
            end
        elseif playerInput == 1 then
            timing = .1
            if playerIndex == 0 then
                timing = 1
            end
            hitSuccess = 0
            checkRhythm()
            if playerHit == 1 then
                playerHit = 0
                if hitSuccess == 1 then
                    rhythmStart = time
                    love.audio.stop(note)
                    love.audio.play(note)
                    --[[
                    sizeBoost = 1
                    player.sx = player.sx + sizeIncrease
                    player.sy = player.sy + sizeIncrease
                    player.x = player.x - sizeIncrease/2
                    player.y = player.y - sizeIncrease/2
                    sizeTime = time
                    ]]
                    player.dir = player.dir * -1
                    playerIndex = playerIndex + 1
                    player.animation = rhythms[playerRhythm][#rhythms[playerRhythm]]
                    player.startTime = time
                    player.frame = 1
                    if player.animation == 7 then
                        table.insert(balls,{player.x + player.sx / 2 + player.dir * player.sx/2.5-15,player.y+50,600,player.dir})
                    end
                end
                if playerIndex > #rhythms[playerRhythm] - 1 or hitSuccess == 0 then
                    playerInput = 0
                    startRhythm(math.random(#rhythms),1)
                end
            end
        end
    else
        if time >= rhythmStart then
            counting = 0
        end
    end
end


function checkRhythm()
    if playerIndex == 0 then
        hitTime = rhythmStart + .5
    else
        hitTime = rhythms[playerRhythm][playerIndex] + rhythmStart
    end
    hitScore = math.abs(time - (hitTime))
    if time > hitTime + timing then
        playerHit = 1
    end
    if time > hitTime - timing and time < hitTime + timing and playerHit == 1 then
        hitSuccess = 1
        hits = hits + 1
        if hitScore < .03 then
            kingHappiness = kingHappiness + 2
        elseif hitScore < .1 then
            kingHappiness = kingHappiness + 1
        else 
            -- Neutral
        end
    elseif playerHit == 1 then
        hitSuccess = 0
        playerInput = 0
        king.animation = 4
        king.frame = 1
        king.startTime = time
        if hitScore > .15 then
            kingHappiness = kingHappiness - 10
        else 
            kingHappiness = kingHappiness - 5
        end
    end
end