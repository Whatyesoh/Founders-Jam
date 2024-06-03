function menuMouseMoved(x,y)

end

function gameMouseMoved(x,y)

end

function pauseMouseMoved(x,y)
    
end

function endScreenMouseMoved(x,y)

end

function menuMousePressed(x,y,button)
    if button == 1 then
        buttonPress(menuButtons)
    end
end

function gameMousePressed(x,y,button)

end

function pauseMousePressed(x,y,button)
    if button == 1 then
        buttonPress(pauseButtons)
    end
end

function endScreenMousePressed(x,y,button)
    if button == 1 then
        buttonPress(endButtons)
    end
end