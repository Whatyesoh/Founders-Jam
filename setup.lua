function setup()
    --Initialize window
    love.window.setMode(1050,700)
    love.window.setFullscreen(false)
    love.window.setVSync(0)

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    time = 0

    scene = 1

    font = love.graphics.newFont(14)
    bigFont = love.graphics.newFont(20)
    hugeFont = love.graphics.newFont(40)

    --Initialize animations
    animations = {}
    unloadedAnimations = {
        {"Test",.1},
        {"notePlayed",.1},
        {"countDown",1.5},
        {"kingFistShake",1.2},
        {"jesterIdle",1},
        {"jesterKick",.3},
        {"jesterJuggle",.15},
        {"jesterHorn",.5},
        {"kingClap",1.2}
    }

    for j,k in ipairs(unloadedAnimations) do
        generateAnimation("Textures/Animations/"..k[1].."/",k[2])
    end

    --Initialize sprites
    sprites = {}
    unloadedSprites = {"Background","Jester","noteTile","background2","ThoughtBubble","kingBar","KingSeated","ball","note1"}
    generateSprites()

    --Initialize objects
    objects = {}
    balls = {}
    notes = {}

    player = {}
    createObject(player,0,0,0,150,400,100,250,2,1)

    noteTile = {}
    createObject(noteTile,0,0,0,500,150,50,50,2,1)

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

    easyRhythms = {
        {.5,.5,.2},
        {.5,.5,.2}
    }

    easyMoves = {
        {6,6,6,6},
        {7,7,7,7}
    }

    hardRhythms = {
        {.5,.5,.2},
        {.2,.2,.4,.2},
        {.15,.15,.15,.15},
        {.15,.2,.2,.5},
        {.2,.3,.4,.5},
        {.4,.4,.2,.4}
    }

    hardMoves = {
        {6,6,6,6},
        {8,8,8,7,7},
        {7,8,6,7,6},
        {7,7,7,7,7},
        {8,8,8,8,8},
        {6,6,6,6,6}
    }


    --Initialize buttons

    menuButtons = {}
    pauseButtons = {}
    endButtons = {}

    createButton(menuButtons,width/2-40,400,80,20,"Start",1)
    createButton(menuButtons,width/2-40,450,80,20,"Quit",2)

    createButton(pauseButtons,width/2-40,400,80,20,"Resume",1)
    createButton(pauseButtons,width/2-40,450,80,20,"Menu",3)

    createButton(endButtons,width/2-40,400,80,20,"Menu",3)
    createButton(endButtons,width/2-40,450,80,20,"Quit",2)
end