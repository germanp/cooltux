
-- Posibles direcciones
IZQUIERDA=-1
DERECHA=1

GRAVEDAD=0.2

Personaje = {}

function Personaje.new(x,y,ancho,alto,vel)
   local o = game.model.Rectangulo.new(x,y,ancho,alto)
   o.vel = vel
   o.direccion = DERECHA
   o.dy = 0
   o.anim = nil -- Iniciar en la subclase !!!
   o.estadoActual = nil -- Iniciar en la subclase !!!
   o.estados = nil -- Iniciar en la subclase !!!

   function o:distanciaAlSuelo(incremento)
      local flag=false
      for i=0, incremento, 1 do
	 if ( game:esSuelo(self:getCenterX(),self:getBottom() + i) ) then
	    return i, true
	 end
      end
      return incremento, false
   end

   function o:cambiarDeEstado (nuevoEstado)
      self.estadoActual=nuevoEstado
      self.estados[nuevoEstado].init(self)
   end

   function o:mover(dt)
      self._x=self._x + dt*self.vel*self.direccion
      local ancho=love.graphics.getWidth()
      if ( self:getCenterX() <= 0 ) then
	 self._x=self._x+ancho
      elseif ( self:getCenterX() >= ancho ) then
	 self._x=self._x-ancho
      end
   end

   function o:dibujar()
      self.anim:dibujar(self._x,self._y)
      -- Debug --
      love.graphics.setColor(255,0,0)
      love.graphics.setPointSize(3)
      love.graphics.point(self:getLeft(),self:getTop())
      love.graphics.point(self:getLeft(),self:getBottom())
      love.graphics.point(self:getRight(),self:getTop())
      love.graphics.point(self:getRight(),self:getBottom())
      love.graphics.setColor(255,255,255)
      
      --love.graphics.print("x: "..o.x.." -- y: "..o.y, 690, 0)
   end   

   function o:actualizar(dt)
      self.estados[self.estadoActual].run(self,dt)
      self.anim:actualizar(dt)
   end

   function o:retomarEstado()
      self.estados[self.estadoActual].init(self)
   end


   return o
end