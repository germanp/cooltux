local M = {}

-- Constructor --
 function M.new()
   local o = {}
   o.izquierda = nil -- Iniciar en las subclases !!!
   o.derecha   = nil -- Iniciar en las subclases !!!
   o.actual    = nil -- Iniciar en las subclases !!!

   function o:caminando(direccion)
      if ( direccion == IZQUIERDA ) then
	 self.actual=self._izquierda
      else
	 self.actual=self._derecha
      end
      self.actual:play()
   end   
   
   function o:actualizar(dt)
      self.actual:update(dt)
   end
   
   function o:dibujar(x,y)
      self.actual:draw(x,y,0,game.scalingX,game.scalingY)
   end

   return o
 end

return M