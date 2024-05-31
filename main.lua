--Include all other lua files
require("animations")
require("sprites")
require("objects")
require("rhythm")

--VSCode setup 
if arg[2] == "debug" then
    require("lldebugger").start()
end
  
io.stdout:setvbuf("no")

--Game setup
function love.load()
    --Initialize window
    love.window.setMode(1050,700)
    love.window.setFullscreen(false)
    love.window.setVSync(0)

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    time = 0

    --Initialize animations
    animations = {}
    unloadedAnimations = {{"Test",.1},{"notePlayed",.1},{"countDown",1.5},{"kingFistShake",1.2},{"jesterIdle",1},{"jesterKick",.4},{"jesterJuggle",.15}}

    for j,k in ipairs(unloadedAnimations) do
        generateAnimation("Textures/Animations/"..k[1].."/",k[2])
    end

    --Initialize sprites
    sprites = {}
    unloadedSprites = {"Background","Jester","noteTile","background2","ThoughtBubble","kingBar","KingSeated","ball"}
    generateSprites()

    --Initialize objects
    objects = {}
    balls = {}

    player = {}
    createObject(player,0,0,0,150,400,100,250,2,1)

    noteTile = {}
    createObject(noteTile,0,0,0,500,150,50,50,3,1)

    countDown = {}
    createObject(countDown,0,0,0,300,150,400,440,0,1)

    kingBar = {}
    createObject(kingBar,0,0,0,550,600,500,100,6,1)

    king = {}
    createObject(king,0,0,0,740,380,150,250,7,1)


    --Initialize audio
    note = love.audio.newSource("Sounds/note.mp3","static")

    --Initialize shaders
    crt = love.graphics.newShader("Shaders/CRT.frag")
    edgeDetect = love.graphics.newShader("Shaders/EdgeDetection.frag")

    predraw = love.graphics.newCanvas()
    predraw2 = love.graphics.newCanvas()

    --Initialize rhythms
    easyRhythms = {}
    mediumRhythms = {}
    hardRhythms = {}

    rhythms = {
        {.5,.5,.2,6},
        {.2,.2,.4,.2,6},
        {.15,.15,.15,.15,7},
        {.15,.2,.2,.5,7},
        {.2,.3,.4,.5,6}
    }
    playedRhythm = 0
    rhythmStart = 0
    rhythmIndex = 1
    firstNote = 0
    counting = 0
    allowCounting = 1
    
    playerInput = 0
    playerRhythm = 0
    playerIndex = 1
    playerHit = 0
    sizeBoost = 0
    sizeIncrease = 60
    sizeTime = 0

    kingHappiness = 50
    kingMod = 0

end

function love.keypressed(key)
    if key == "space" then
        if playerInput == 1 then
            playerHit = 1
        end
    end
    if key == "left" then
        player.animation = 7
        player.startTime = time
        player.frame = 1
        table.insert(balls,{player.x + player.sx / 2 + player.dir * player.sx/2.5-15,player.y+50,600,player.dir})
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
end

function love.mousepressed(x,y,button)
end

function love.mousemoved(x,y)
end

function love.update(dt)
    time = time + dt

    for i,v in ipairs(balls) do
        v[2] = v[2] - v[3] * dt
        v[3] = v[3] - 1500 *dt
        v[1] = v[1] - 120 * v[4] * dt
        if v[2] > player.y + 50 then
            table.remove(balls,i)
        end
    end

    playRhythm()

    if player.animation == 0 then
        player.startTime = time
        player.animation = 5
        player.frame = 1
    end

    for i,object in ipairs(objects) do
        playAnimation(object)
    end

    


end

function love.draw()

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
    

end