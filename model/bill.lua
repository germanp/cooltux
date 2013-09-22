-- Bill --

local M = {}

function M.new(left,bottom)
   local o = Personaje.new(left,bottom,24,38,200)
   
   o.anim = game.render.Bill.new()
   o._direccion = IZQUIERDA
   o._nivel = 6
   o.estados = {
      caminando = {
	 init = function (self)
	    self.anim:caminando(self.direccion)
	    local nivel = self._nivel - 1
	    for i=nivel, 1, -1 do
	       if ( game.nivel[i][1]:getTop() == self:getBottom() ) then
		  self._nivel=i
		  break
	       end
	    end
	 end,
	 run = function(self,dt)
	    self:mover(dt)
	    if ( not game:esSuelo(self:getCenterX(), self:getBottom()) ) then
	       self:cambiarDeEstado("cayendo")
	    elseif ( self:estaEntrando() ) then
	       self:cambiarDeEstado("entrando")
	    end
	 end
      },
      cayendo = {
	 init = function (self)

	 end,
	 run = function(self,dt)
	    self:mover(dt)
	    self.dy = self.dy + GRAVEDAD
	    local dy=math.floor(self.dy)
	    local pisaSuelo
	    dy,pisaSuelo=self:distanciaAlSuelo(dy)
	    if ( pisaSuelo ) then
	       self:resetDy()
	       self:cambiarDeEstado("caminando")
	    end
	    self._y = self._y + dy	       
	 end
      },
      entrando = {
	 init = function (self)
	    self._y=self._y - game.coord.escalarX( 10 )
	 end,
	 run = function(self, dt)
	    self:mover(dt)
	    if ( self.direccion == IZQUIERDA ) and ( self:getRight() < game.tuboInf[IZQUIERDA]:getRight() ) then
		  self:cambiarDeEstado("saliendo")
	    else
	       if ( self:getLeft() > game.tuboInf[DERECHA]:getLeft() ) then
	    	  self:cambiarDeEstado("saliendo")
	       end
	    end
	 end
      },
      saliendo = {
	 init = function (self)
	    self.direccion=self.direccion*-1 -- Invierte la direccion
	    self:setBottom( game.Y_ORIG_MALOS )
	 end,
	 run = function (self,dt)
	    self:mover(dt)
	    if ( self.direccion == IZQUIERDA ) then
	       if ( self:getRight() < game.tuboSup[DERECHA]:getLeft() ) then
		  self:cambiarDeEstado("cayendo")
	       end
	    else
	       if ( self:getLeft() > game.tuboSup[IZQUIERDA]:getRight() ) then
		  self:cambiarDeEstado("cayendo")
	       end
	    end
	 end
      }
   }

   function o:estaEntrando()
      return (
	 ( self:getBottom() == game.nivel[1][1]:getTop()) )
      and (( self.direccion == IZQUIERDA and
	    self:getLeft() < game.tuboInf[IZQUIERDA]:getRight()
		) or (
	       self.direccion == DERECHA and
		  self:getRight() > game.tuboInf[DERECHA]:getLeft()
		     ))
   end

   function o:resetDy()
      self.dy=8
   end

   o.estadoActual="caminando"
   o:resetDy()
   return o
end

return M