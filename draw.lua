function mainMenuDraw() 
    title = love.graphics.newText(font,"JESTER GAME TITLE TBD")
    love.graphics.draw(title,width/2 - title:getWidth()/2,200)
    drawButtons(menuButtons)
end

function gameDraw()
    love.graphics.setShader()
    love.graphics.setCanvas(predraw)

    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.draw(sprites[4],0,0,0,.7,.7)
    love.graphics.draw(sprites[1],0,0,0,.7,.7)
    love.graphics.draw(sprites[5],200,0,0,1,1)
    for i,object in ipairs(objects) do
        drawAnimation(object)
    end
    for i,v in ipairs(balls) do
        love.graphics.draw(sprites[8],v[1],v[2],0,.15,.15)
    end
    love.graphics.setColor(1,0,0,1)
    love.graphics.rectangle("fill",kingBar.x+30,kingBar.y+57,(kingBar.sx-47)*kingHappiness/100,kingBar.sy/4)
    love.graphics.setColor(1,1,1,1)

    love.graphics.setCanvas(predraw2)
    love.graphics.draw(predraw)
    love.graphics.setShader(edgeDetect)
    love.graphics.draw(predraw)

    love.graphics.setShader(crt)
    love.graphics.setCanvas()
    love.graphics.draw(predraw2)
    love.graphics.setShader()
end

function pauseDraw()
    title = love.graphics.newText(font,"Pused")
    love.graphics.draw(title,width/2 - title:getWidth()/2,200)
    drawButtons(pauseButtons)
end

function endScreenDraw()

end