--- Calcula las dimensiones del escenario según el tamaño de la
--  pantalla.
--  @param ancho Ancho en píxeles de la pantalla.
--  @param alto  Alto en píxeles de la pantalla


local M = {
  -- Constructor --
  new = function()
     local o={}

     o.nivel={
	[1] = {
	   malos = {},
	   M_.Rectangulo.new(0,540,800,60) 
	},
	[2] = {
	   malos = {},
	   M_.Piso.new(0,420,300,20), M_.Piso.new(500,420,300,20)
	},
	[3] = {
	   malos = {},
	   M_.Piso.new(0,320,100,20), M_.Piso.new(700,320,100,20)
	},
	[4] = {
	   malos = {},
	   M_.Piso.new(200,300,400,20)
	},
	[5] = {
	   malos = {},
	   M_.Piso.new(0,180,350,20), M_.Piso.new(450,180,350,20),
	},
	[6] = {
	   malos = {},
	}
     }

     o.tuboInf = {
	[IZQUIERDA] = M_.Rectangulo.new(0,540-64,96,64),
	[DERECHA]   = M_.Rectangulo.new(704,540-64,96,64)
     }
     o.tuboSup = { 
	[IZQUIERDA] = M_.Rectangulo.new(0,180-70,96,64),
	[DERECHA]   = M_.Rectangulo.new(704,180-70,96,64)
     }

     o.Y_ORIG_MALOS = o.tuboSup[IZQUIERDA]:getY() -- Coord. Y donde aparecen los malos al principio

     game.render.tiles.cargarTuberiaDer()
     game.render.tiles.cargarTuberiaIzq()

     function o:dibujar()
	--
	game.render.dibujar(self.tuboInf[IZQUIERDA],R_.tiles.tuboIzq)
	game.render.dibujar(self.tuboInf[DERECHA],R_.tiles.tuboDer)
	game.render.dibujar(self.tuboSup[IZQUIERDA],R_.tiles.tuboIzq)
	game.render.dibujar(self.tuboSup[DERECHA],R_.tiles.tuboDer)

	love.graphics.rectangle("fill",
				self.nivel[1][1]:getX(),
				self.nivel[1][1]:getY(),
				self.nivel[1][1]:getAncho(),
				self.nivel[1][1]:getAlto())
 	self.nivel[2][1]:dibujar()
	self.nivel[2][2]:dibujar()
	self.nivel[3][1]:dibujar()
	self.nivel[3][2]:dibujar()
	self.nivel[4][1]:dibujar()
	self.nivel[5][1]:dibujar()
	self.nivel[5][2]:dibujar()

     end
     
     function o:esSuelo(x, y)
	x=math.floor(x)
	for i=1, 5, 1 do
	   if ( y == self.nivel[i][1]:getTop() ) then
	      for _, piso in ipairs(self.nivel[i]) do
		 if ( x >= piso:getLeft() and x <= piso:getRight() ) then
		    return true
		 end
	      end
	   end
	end
	return false
     end
     
     function o:colisionInferior(objeto)
	local piso
	for i=2, 5, 1 do
	   for _, piso in ipairs(self.nivel[i]) do
	      if ( colisionRectangulos(objeto,piso) ) then
		 return true,piso
	      end
	   end
	end
	return false
     end

     function o:actualizar(dt)
	for i=2, 5, 1 do
	   for _, piso in ipairs(self.nivel[i]) do
	      piso:actualizar(dt)
	   end
	end
     end
     
     return o
  end,
}


function colisionRectangulos(rect1, rect2)
   local flag=true
   if rect1:getLeft() >= rect2:getRight() then
      flag=false
   elseif rect1:getRight() <= rect2:getLeft() then
      flag=false
   elseif rect1:getBottom() <= rect2:getTop() then
      flag=false
   elseif rect1:getTop() > rect2:getBottom() then
      flag=false
   end

   return flag
end

return M