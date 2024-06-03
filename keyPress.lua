function mainMenuKeyPress (key)

end

function gameKeyPress (key)
    if key == "space" then
        if playerInput == 1 then
            playerHit = 1
        end
    end
    if key == "left" then
        if playerInput == 1 then
            playerHit = 6
        end
    end
    if key == "right" then
        if playerInput == 1 then
            playerHit = 8
        end
    end
    if key == "up" then
        if playerInput == 1 then
            playerHit = 7
        end
    end
    if key == "escape" then
        scene = 3
    end
end

function pauseKeyPress (key)
end

function endScreenKeyPress (key)

end