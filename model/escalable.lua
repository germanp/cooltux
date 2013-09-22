local M={}

function M.new(x,y)
   o={}

   function o:setX(x)
      self._x = math.floor ( x * game.scalingX )
   end

   function o:setY(y)
      self._y = math.floor ( y * game.scalingY )
   end

   function o:getX()
      return self._x
   end
   
   function o:getY()
      return self._y
   end

   o:setX(x)
   o:setY(y)
   
   return o
end

return M