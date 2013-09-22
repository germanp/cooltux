local M = {
   -- Variables Estáticas --
   izquierda   = 0,
   derecha     = 0,
   gameover    = 0,
   saltandoIzq = 0,
   saltandoDer = 0,

   -- Método Estático --
   cargarSprites = function()
      tux=game.render.Tux
      tux.izquierda   = love.graphics.newImage("img/tux/izquierda.png")
      tux.derecha     = love.graphics.newImage("img/tux/derecha.png")
      tux.gameover    = love.graphics.newImage("img/tux/gameover.png")
      tux.saltandoIzq = love.graphics.newImage("img/tux/salto_izquierda.png")
      tux.saltandoDer = love.graphics.newImage("img/tux/salto_derecha.png")
   end,

   -- Constructor --
   new = function()
      local o = game.render.Animacion.new()
      a=game.render.Tux
      if ( a.izquierda == 0 ) then a.cargarSprites() end
      o._izquierda    = newAnimation(a.izquierda,42,41,0.1,0)
      o._derecha      = newAnimation(a.derecha,42,41,0.1,0)
      o._gameover     = newAnimation(a.gameover,42,41,0.1,0)
      o._saltandoIzq  = newAnimation(a.saltandoIzq,42,41,0.1,0)
      o._saltandoDer  = newAnimation(a.saltandoDer,42,41,0.1,0)

      function o:muriendo() self.actual=self._gameover end

      function o:saltando (direccion)
	 if ( direccion == IZQUIERDA ) then
	    self.actual=self._saltandoIzq
	 else
	    self.actual=self._saltandoDer
	 end
	 self.actual:play()
      end

      function o:parado(direccion)
	 if ( direccion == IZQUIERDA ) then
	    self.actual=self._izquierda
	 else
	    self.actual=self._derecha
	 end
	 self.actual:seek(6)
	 self.actual:stop()
      end

      o:parado(IZQUIERDA)
      return o
   end
}

return M