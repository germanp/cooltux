-- Jugador (Tux) --

M = {
   -- Constructor --
   new = function(x,y)
      local o = Personaje.new(x or 200,y or game.nivel[1][1]:getTop(),42,41,200)
      o.dy = 0
      o.anim = game.render.Tux.new()

      -- Máquina de estados --
      o.estados = {
	 -- Acciones a realizar en el estado PARADO
	 parado = {
	    init = function(self)
	       self.anim:parado(self.direccion)
	    end,
	    run = function(self,dt)
	       if ( love.keyboard.isDown("left") ) then
		  self.direccion=IZQUIERDA
		  self:cambiarDeEstado("caminando")
	       elseif (love.keyboard.isDown("right") ) then
		  self.direccion=DERECHA
		  self:cambiarDeEstado("caminando")
	       elseif ( love.keyboard.isDown("up") ) then
		  self:cambiarDeEstado("saltando")
	       end
	    end,
	 },
	 -- Acciones a realizar en el estado CAMINANDO
	 caminando = {
	    init = function(self)
	       self.anim:caminando(self.direccion)
	       self.estadoActual="caminando"
	    end,
	    run = function(self,dt)
	       if ( not game:esSuelo(self:getCenterX(), self:getBottom()) ) then
		  self:cambiarDeEstado("cayendo")
	       else
		  if ( love.keyboard.isDown("up") ) then
		     self:cambiarDeEstado("saltando")
		  elseif ( love.keyboard.isDown("left") ) then
		     self.direccion=IZQUIERDA
		     self:mover(dt)
		     self.anim:caminando(IZQUIERDA)
		  elseif ( love.keyboard.isDown("right") ) then
		     self.direccion=DERECHA
		     self:mover(dt)
		     self.anim:caminando(DERECHA)
		  else
		     self:cambiarDeEstado("parado")
		  end
	       end
	    end,
	 },
	 -- Acciones a realizar en el estado SALTANDO
	 saltando = {
	    init = function(self)
	       self.estadoActual="saltando"
	       self.dy=-8.4
	       self.anim:saltando(self.direccion)
	    end,

	    run = function(self,dt)
	       self:moverSoloHaciaAdelante(dt)
	       self.dy = self.dy + GRAVEDAD
	       local dy=math.floor(self.dy)

	       if ( self.dy > 0 ) then
		  self:cambiarDeEstado("cayendo")
	       else
		  local piso
		  flag, piso=game:colisionInferior(self)
		  if ( flag ) then
		     self.dy=1
		     piso:levantarBloque(self:getCenterX())
		  end
	       end
	       self._y = self._y + dy
	    end,
	 },
	 -- Acciones a realizar en el estado CAYENDO
	 cayendo = {
	    init = function(self)
	       self.estadoActual="cayendo"
	       self.anim:saltando(self.direccion)
	    end,
	    run = function(self,dt)
	       self:moverSoloHaciaAdelante(dt)
	       self.dy = self.dy + GRAVEDAD
	       local dy=math.floor(self.dy)
	       local pisaSuelo
	       dy,pisaSuelo=self:distanciaAlSuelo(dy)
	       if ( pisaSuelo ) then
		  self:cambiarDeEstado("parado")
	       end
	       self._y = self._y + dy
	    end,
	 },

      }

      function o:moverSoloHaciaAdelante (dt)
	 if ( self.direccion < 0 ) then
	    if ( love.keyboard.isDown("left") ) then
	       self.direccion=IZQUIERDA
	       self:mover(dt)
	    end
	 else
	    if ( love.keyboard.isDown("right") ) then
	       self.direccion=DERECHA
	       self:mover(dt)
	    end
	 end      
      end
     
      o:cambiarDeEstado("parado")

      -- incrementarVel = function(self)
      --    if ( self.vel < self.velMax ) then
      -- 	 self.vel=self.vel*1.1
      --    end
      -- end,

      -- Cambios de estado --
      -- Estado parado => 0

      -- -- Estado caminando_izq => 1
      -- caminandoIzq = function(self)
      --    self.estadoActual=1
      --    self.anim:caminandoIzq()
      -- end,
      -- -- Estado caminando_der => 2
      -- caminandoDer = function(self)
      --    self.estadoActual=2
      --    self.anim:caminandoDer()
      -- end,
      return o
   end
}

return M