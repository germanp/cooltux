-- Render o Vista --
local M = {
   anal      = require('render.anal'),
   Animacion = require('render.animacion'),
   Tux       = require('render.tux'),
   Bill      = require('render.bill'),
   tiles     = require('render.tiles'),
}

function M.dibujar(obj,drawable)
   love.graphics.draw(drawable, obj:getX(),obj:getY(),0,game.scalingX,game.scalingY)
end

return M