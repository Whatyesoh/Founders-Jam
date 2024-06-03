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

function playRhythm (rhythms, moves)
    if counting == 0 then
        if playedRhythm > 0 then
            if firstNote == 0 then
                firstNote = 1

                noteTile.dir = noteTile.dir * -1
                noteTile.animation = moves[playedRhythm][1]
                noteTile.startTime = time
                noteTile.frame = 1
                if noteTile.animation == 7 then
                    table.insert(balls,{noteTile.x + noteTile.sx / 2 + noteTile.dir * noteTile.sx/2.5-15,noteTile.y+50,600,noteTile.dir})
                end
                if noteTile.animation == 8 then
                    table.insert(notes,{noteTile.x + noteTile.sx / 2 - noteTile.dir * noteTile.sx/2.5-15,noteTile.y,300,noteTile.dir})
                end

                love.audio.stop(note)
                love.audio.play(note)
            end
            if time - rhythmStart >= rhythms[playedRhythm][rhythmIndex] then

                noteTile.dir = noteTile.dir * -1
                noteTile.animation = moves[playedRhythm][rhythmIndex+1]
                noteTile.startTime = time
                noteTile.frame = 1
                if noteTile.animation == 7 then
                    table.insert(balls,{noteTile.x + noteTile.sx / 2 + noteTile.dir * noteTile.sx/2.5-15,noteTile.y+50,600,noteTile.dir})
                end
                if noteTile.animation == 8 then
                    table.insert(notes,{noteTile.x + noteTile.sx / 2 - noteTile.dir * noteTile.sx/2.5-15,noteTile.y,300,noteTile.dir})
                end

                love.audio.stop(note)
                love.audio.play(note)
                rhythmStart = rhythmStart + rhythms[playedRhythm][rhythmIndex]
                rhythmIndex = rhythmIndex + 1
                if rhythmIndex > #rhythms[playedRhythm] then
                    playerInput = 1
                    hits = 0
                    hitScore = 0
                    playerIndex = 0
                    playerRhythm = playedRhythm
                    playedRhythm = 0
                    rhythmStart = time
                    -- Play King AnimTION
                end
            end
        elseif playerInput == 1 then
            timing = .1
            if playerIndex == 0 then
                timing = 1
            end
            hitSuccess = 0
            checkRhythm(rhythms,moves)
            if playerHit > 0 then
                playerHit = 0
                if hitSuccess == 1 then

                    --Successful beat hit

                    rhythmStart = time
                    love.audio.stop(note)
                    love.audio.play(note)
                    playerIndex = playerIndex + 1

                    player.dir = player.dir * -1
                    player.animation = moves[playerRhythm][playerIndex]
                    player.startTime = time
                    player.frame = 1
                    if player.animation == 7 then
                        table.insert(balls,{player.x + player.sx / 2 + player.dir * player.sx/2.5-15,player.y+50,600,player.dir})
                    end
                    if player.animation == 8 then
                        table.insert(notes,{player.x + player.sx / 2 - player.dir * player.sx/2.5-15,player.y+30,300,player.dir})
                    end

                end
                if playerIndex > #rhythms[playerRhythm] or hitSuccess == 0 then

                    if playerIndex > #rhythms[playerRhythm] then
                        king.animation = 9
                        king.frame = 1
                        king.startTime = time
                    end

                    playerInput = 0
                    startRhythm(math.random(#usedRhythms),1.3)
                end
            end
        end
    else
        if time >= rhythmStart then
            counting = 0
        end
    end
end


function checkRhythm(rhythms,moves)
    if playerIndex == 0 then
        hitTime = rhythmStart + .5
    else
        hitTime = rhythms[playerRhythm][playerIndex] + rhythmStart
    end
    hitScore = math.abs(time - (hitTime))
    if time > hitTime + timing then
        playerHit = moves[playerRhythm][playerIndex+1]
    end
    miss = 0
    if time > hitTime - timing and time < hitTime + timing and playerHit == moves[playerRhythm][playerIndex+1] then
        hitSuccess = 1
        hits = hits + 1
        if hitScore < .03 then
            kingHappiness = kingHappiness + 2
        elseif hitScore < .1 then
            kingHappiness = kingHappiness + 1
        else 
            -- Neutral
        end
        if kingHappiness > 100 then
            kingHappiness = 100
        end
    else
        miss = 1
    end
    if (miss == 1 and playerHit == moves[playerRhythm][playerIndex+1]) or (playerHit > 0 and playerHit ~= moves[playerRhythm][playerIndex+1]) then
        hitSuccess = 0
        playerInput = 0
        king.animation = 4
        king.frame = 1
        king.startTime = time
        if hitScore > .15 then
            kingHappiness = kingHappiness - 20
        else 
            kingHappiness = kingHappiness - 10
        end
        if kingHappiness < 0 then
            kingHappiness = 0
        end
    end
end

function addRhythms(rhythms,moves) 
    for j,k in ipairs(rhythms) do
        table.insert(usedRhythms,k)
    end
    for j,k in ipairs(moves) do
        table.insert(usedMoves,k)
    end
end