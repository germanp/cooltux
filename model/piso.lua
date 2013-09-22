local M={}

function M.new(left,bottom,ancho,alto)
   o = game.model.Rectangulo.new(left,bottom,ancho,alto)
   o.cantBloques    = ancho/50
   o.bloqueLevantado = {nroBloque = 0, y = 0}
   o.ANCHO_BLOQUE = game.coord.escalarX( 50 )
   
   if ( not game.render.tiles.bloque ) then
      game.render.tiles.cargarBloque()
   end

   function o:_dibujar(x,y)
      love.graphics.draw(
	 game.render.tiles.bloque,
	 x,
	 y,
	 0,
	 game.scalingX,
	 game.scalingY
			)
   end

   function o:dibujar()
      local i
      local x=self._x
      for i=1, self.cantBloques, 1 do
	 if ( self.bloqueLevantado.nroBloque == i ) then
	    self:_dibujar(x,self.bloqueLevantado.y)
	 else
	    self:_dibujar(x,self._y)
	 end
	 x = x + self.ANCHO_BLOQUE
      end
   end

   function o:levantarBloque(y)
      self.bloqueLevantado.nroBloque = 
	 math.floor( ( y - self._x ) / self.ANCHO_BLOQUE ) + 1
      self.bloqueLevantado.y = self._y
   end

   function o:actualizar(dt)
      if ( self.bloqueLevantado.nroBloque ~= 0 ) then
	 self.bloqueLevantado.y = self.bloqueLevantado.y - dt * 90
	 if ( self.bloqueLevantado.y < self._y - 15 ) then
	    self.bloqueLevantado.y=0
	    self.bloqueLevantado.nroBloque=0
	 end
      end
   end

   return o
end

return M