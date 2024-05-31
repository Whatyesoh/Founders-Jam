function createObject(object, animation, frame, startTime, x, y, sx, sy, still, dir)
    object.animation = animation
    object.frame = frame
    object.startTime = startTime
    object.x = x
    object.y = y
    object.sx = sx
    object.sy = sy
    object.still = still
    object.dir = dir
    table.insert(objects,object)
end