
local M = {}

function M.new(x,y)
   local o=game.model.Rectangulo.new(x,y,64,64)
   if ( game.render.tiles.tuberia == 0 ) then
      game.render.tiles.cargarTuberia()
   end   

   function o:dibujar()
      love.graphics.draw(game.render.tiles.tuberia,
			 self._x,self._y)
   end
   return o
end

return M