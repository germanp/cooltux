local M = {}


function M.new(left,bottom,ancho,alto)
   local sx=game.coord.escalarX( ancho )
   local sy=game.coord.escalarY( alto )
   o = {
      _x = 0,
      _y = 0,
      _ancho = sx,
      _alto = sy,
   }

   function o:getTop()
      return self._y
   end

   function o:getBottom()
      return self._y+self._alto
   end

   function o:setBottom(bottom)
      self._y = bottom - self._alto
   end

   function o:getLeft() return self._x end

   function o:setLeft(left) self._x=left end

   function o:getRight()
      return self._x + self._ancho
   end

   function o:getCenterX()
      return self._x+self._ancho/2
   end

   function o:getAncho() return self._ancho end
   function o:setAncho(ancho) self._ancho=ancho end

   function o:getAlto() return self._alto end
   function o:setAlto(alto) self._alto=alto end

   function o:getX() return self._x end
   function o:getY() return self._y end

   o:setLeft   ( game.coord.escalarX( left ) )
   o:setBottom ( game.coord.escalarY( bottom ) )

   return o
end

return M