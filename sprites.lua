--Collects files within sprites folder into an array of images
function generateSprites()
    for i,v in ipairs(unloadedSprites) do
        table.insert(sprites,love.graphics.newImage("Textures/Sprites/" .. v .. ".png"))
    end
end