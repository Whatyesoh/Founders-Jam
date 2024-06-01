--Include all other lua files
require("animations")
require("sprites")
require("objects")
require("rhythm")
require("draw")
require("update")
require("keyPress")
require("setup")
require("buttons")
require("mouse")

--VSCode setup 
if arg[2] == "debug" then
    require("lldebugger").start()
end
  
io.stdout:setvbuf("no")

--Game setup
function love.load()
    setup()
end

function love.keypressed(key)
    if scene == 2 then
        gameKeyPress(key)
    end
    if scene == 3 then
        pauseKeyPress(key)
    end
end

function love.mousepressed(x,y,button)
    if scene == 1 then
        menuMousePressed(x,y,button)
    end
    if scene == 3 then
        pauseMousePressed(x,y,button)
    end
end

function love.mousemoved(x,y)
    if scene == 1 then
        menuMouseMoved(x,y)
    end
    if scene == 3 then
        pauseMouseMoved(x,y)
    end
end

function love.update(dt)
    if scene == 1 then
        mainMenuUpdate(dt)
    end
    if scene == 2 then
        gameUpdate(dt)
    end
    if scene == 3 then
        pauseUpdate(dt)
    end
end

function love.draw()
    if scene == 1 then
        mainMenuDraw()
    end
    if scene == 2 then
        gameDraw()
    end
    if scene == 3 then
        pauseDraw()
    end
end