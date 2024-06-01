function mainMenuKeyPress (key)

end

function gameKeyPress (key)
    if key == "space" then
        if playerInput == 1 then
            playerHit = 1
        end
    end
    if key == "left" then
        player.animation = 8
        player.startTime = time
        player.frame = 1
        table.insert(notes,{player.x + player.sx / 2 - player.dir * player.sx/2.5-15,player.y,300,player.dir})
    end
    if key == "right" then
        player.dir = player.dir * -1
    end
    if key == "1" then
        if playedRhythm == 0 then
            allowCounting = 1
        end
        startRhythm(math.random(#rhythms),allowCounting * 1.6)
    end
    if key == "escape" then
        scene = 3
    end
end

function pauseKeyPress (key)
end

function endScreenKeyPress (key)

end