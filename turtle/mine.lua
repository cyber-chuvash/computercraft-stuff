
local function digAndMove(n)
    n = n or 1
    local i = 1
    while i <= n do
        turtle.dig()
        local didMove = turtle.forward()
        if didMove then
            i = i + 1
        else
            print('Could not advance forward, trying to dig and move again.')
        end
    end
end

local function goHome(target_x, curr_x, curr_y, curr_z)
    if curr_y % 2 == 0 then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
    for _ = 1, curr_z do turtle.forward() end
    for _ = 1, curr_y do turtle.down() end
    turtle.turnRight()
    local x_to_home
    if curr_y % 2 == 1 then
        x_to_home = curr_x
    else
        x_to_home = target_x - curr_x
    end
    for _ = 1, x_to_home do turtle.forward() end
end

local function stripVerticalLayer(x, y)
    digAndMove()
    turtle.turnRight()
    for y_pos = 1, y do
        digAndMove(x-1)
        print(string.format('Digged out a row of blocks (%d/%d)', y_pos, y))
        if y_pos ~= y then
            print('Moving up to the next row')
            turtle.digUp()
            turtle.up()
            turtle.turnRight()
            turtle.turnRight()
        end
    end
    for _ = 1, y do turtle.down() end
    if y % 2 ~= 0 then
        turtle.turnRight()
        turtle.turnRight()
        for _ = 1, x do turtle.forward() end
    end
    turtle.turnRight()
end

local function mine(x, y, z)
    for z_pos = 1, z do
        print(string.format('Striping vertical layer (%d/%d)', z_pos, z))
        stripVerticalLayer(x, y)
        goHome(x, 1, 1, z_pos)
    end
    print('Returning home')
    turtle.turnRight()
    turtle.turnRight()
    for _ = 1, z do turtle.forward() end
    turtle.turnRight()
    turtle.turnRight()
    print('Done, halting.')
end

local x, y, z = ...
x = tonumber(x)
y = tonumber(y)
z = tonumber(z)
mine(x, y, z)
