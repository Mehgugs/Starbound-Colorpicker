require"/scripts/util.lua"
require"/scripts/colorpicker/data.lua"
require"/scripts/vec2.lua"
require"/scripts/rect.lua"

local img_path = '/interface/easel/spectrumchart.png'
local img_size = {158,55}

local parent = _ENV
local _ENV = setmetatable({}, {__index = parent})

__index = _ENV
__name  = "colorpicker"

function new(name)
    local new = {
         wname = name
        ,mouse = {0,0}
        ,selected = 0
        ,wid = widget.bindCanvas(name)
    }

    -- Override size to ensure the canvas can fit the whole chart.
    widget.setSize(name, img_size)

    -- Create a widget callback,
    --  named as either the one specified in the config or a default using the name.
    new.clickEvent = bind(clickEvent, new)
    local cb = config.getParameter("canvasClickCallbacks", {})[name] or name:gsub("%.", "_").."_clickEvent"
    parent[cb] = new.clickEvent

    new.wid:clear()
    new.wid:drawImage(img_path, {0,0})
    return setmetatable(new, _ENV)
end

local function getByte(value, byte)
    return (value >> (8*byte)) & 0xFF
end

-- Have to clamp x and y to prevent accessing out of the matrix bounds.
function updateColor(c, position)
    local x,y =
     util.clamp(position[1],0,img_size[1]-1)
    ,util.clamp(position[2],0,img_size[2]-1)

    c.selected = spectrum_data[x][y] or 0
    c.mouse = {x,y}
end

function clickEvent(c, _, button, isDown)
    if button == 0 then
        c.down = isDown
    end
end

-- If the mouse is down and inside the canvas, update the color.
function update(c)
    if c.down then
        local mouse = c.wid:mousePosition()
        local pos = widget.getPosition(c.wname)
        local extrema = vec2.add(pos, img_size)
        local r = rect.fromVec2(pos, extrema)
        if rect.contains(r, vec2.add(pos, mouse)) then
            c:updateColor(mouse)
        end
    end
end

function red(c)   return getByte(c.selected, 2) end
function green(c) return getByte(c.selected, 1) end
function blue(c)  return getByte(c.selected, 0) end


function rgb(c) return {c:red(), c:green(), c:blue()} end

function hex(c) return ("%06x"):format(c.selected) end

-- The hue and lightness are estimates using the chart
--  to compute accurate hsl you should use the rgb values.
function hue(c)
    return (c.mouse[1] / img_size[1])*360
end

function lightness(c)
    return 1 - (c.mouse[2] / img_size[2])
end

parent.colorpicker = _ENV
