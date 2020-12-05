
function digAndMove(n)
    n = n or 1
    local i = 1
    while i <= n do
        turtle.dig()
        didMove = turtle.forward()
        if didMove then
            i = i + 1
        else
            print('Could not advance forward, trying to dig and move again.')
        end
    end
end

function stripVerticalLayer(x, y)
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
    for i = 1, y do turtle.down() end
    if y % 2 ~= 0 then
        turtle.turnRight()
        turtle.turnRight()
        for i = 1, x do turtle.forward() end
    end
    turtle.turnRight()
end

function mine(x, y, z)
    for z_pos = 1, z do
        print(string.format('Striping vertical layer (%d/%d)', z_pos, z))
        stripVerticalLayer(x, y)
    end
    print('Returning home')
    turtle.turnRight()
    turtle.turnRight()
    for i = 1, z do turtle.forward() end
    turtle.turnRight()
    turtle.turnRight()
    print('Done, halting.')
end

x, y, z = ...
x = tonumber(x)
y = tonumber(y)
z = tonumber(z)
mine(x, y, z)
