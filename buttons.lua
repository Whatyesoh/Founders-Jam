function createButton(buttonList, x, y, sx, sy, text, id)
    table.insert(buttonList,{x,y,sx,sy,text,id,0})
end

function checkButton(mx, my, button)
    if mx > button[1] and mx < button[1] + button[3] and my > button[2] and my < button[2] + button[4] then
        button[7] = 1
    else
        button[7] = 0
    end
end

function drawButtons(buttons)
    for i,v in ipairs(buttons) do
        text = love.graphics.newText(font,v[5])
        love.graphics.setColor(.5 * v[7],.5 * v[7],.5 * v[7],1)
        love.graphics.rectangle("fill",v[1],v[2],v[3],v[4])
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("line",v[1],v[2],v[3],v[4])
        love.graphics.print(v[5],(v[1] + v[1] + v[3])/2 - text:getWidth()/2,(v[2] + v[2] + v[4])/2 - text:getHeight()/2) 
    end
end

function buttonPress(buttonList)
    for i,v in ipairs(buttonList) do
        if v[7] == 1 then
            if v[6] == 1 then
                scene = 2
                startRhythm(math.random(#rhythms),allowCounting * 1.6)
            end
            if v[6] == 2 then
                love.event.quit()
            end
            if v[6] == 3 then
                scene = 1
            end
        end
    end
end