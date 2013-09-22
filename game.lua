game={
   jugador=0,
   coord = {
      _scalingX = love.graphics.getWidth() / MAXWIDTH,
      _scalingY = love.graphics.getHeight() / MAXHEIGHT,
   },
   enEspera={},
   malos={},
}

function game.coord.escalarX(x)
   return math.floor( x * game.coord._scalingX )
end

function game.coord.escalarY(y)
   return math.floor( y * game.coord._scalingY )
end

game.render = require('render.main')
game.model  = require('model.main')

M_=game.model
R_=game.render

local _game={} -- Privado de este modulo
_game.dtAux   = 0
_game.sigTubo = IZQUIERDA

function game.crearPersonajes(listaPersonajes)
   for i,v in ipairs(listaPersonajes) do
      game.enEspera[i]=game.model[v].new(0,game.Y_ORIG_MALOS)
   end
   game.jugador=game.model.Jugador.new()
end

function game.crearJugador(args)
   game.jugador=_game.Jugador.new(200,game.escenario.piso[8]:getTop())
end

function game.dosificarMalos(dt)
   if next(game.enEspera) then
      local ESPERA=2
      _game.dtAux = _game.dtAux + dt
      if ( _game.dtAux > ESPERA ) then
	 local malo=table.remove(game.enEspera)
	 malo.x = game.tuboSup[_game.sigTubo]:getCenterX()
	 table.insert(game.nivel[6].malos,malo)
	 malo.direccion = _game.sigTubo * -1
	 malo:retomarEstado()

	 -- Resetea el reloj y cambia de tubo
	 _game.sigTubo = _game.sigTubo * -1
	 _game.dtAux= _game.dtAux - ESPERA
      end
   end
end

game.nivel={
   [1] = {
      malos = {},
      [1] = M_.Rectangulo.new(0,600,800,60) 
   },
   [2] = {
      malos = {},
      [1] = M_.Piso.new(0,420,300,20),
      [2] = M_.Piso.new(500,420,300,20)
   },
   [3] = {
      malos = {},
      [1] = M_.Piso.new(0,320,100,20),
      [2] = M_.Piso.new(700,320,100,20)
   },
   [4] = {
      malos = {},
      [1] = M_.Piso.new(200,300,400,20)
   },
   [5] = {
      malos = {},
      [1] = M_.Piso.new(0,180,350,20),
      [2] = M_.Piso.new(450,180,350,20),
   },
   [6] = {
      malos = {},
   }
}

game.tuboInf = {
   [IZQUIERDA] = M_.Rectangulo.new(0,540,96,64),
   [DERECHA]   = M_.Rectangulo.new(704,540,96,64)
}
local bottom=game.nivel[5][1]:getTop()
game.tuboSup = { 
   [IZQUIERDA] = M_.Rectangulo.new(0,bottom,96,64),
   [DERECHA]   = M_.Rectangulo.new(704,bottom,96,64)
}

game.Y_ORIG_MALOS = game.tuboSup[IZQUIERDA]:getBottom() -- Coord. Y donde aparecen los malos al principio

game.render.tiles.cargarTuberiaDer()
game.render.tiles.cargarTuberiaIzq()

function game:dibujar()
   --
   game.render.dibujar(self.tuboInf[IZQUIERDA],R_.tiles.tuboIzq)
   game.render.dibujar(self.tuboInf[DERECHA],R_.tiles.tuboDer)
   game.render.dibujar(self.tuboSup[IZQUIERDA],R_.tiles.tuboIzq)
   game.render.dibujar(self.tuboSup[DERECHA],R_.tiles.tuboDer)
   
   love.graphics.rectangle("fill",
			   self.nivel[1][1]:getLeft(),
			   self.nivel[1][1]:getTop(),
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

function game:esSuelo(x, y)
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
     
function game:colisionInferior(objeto)
   local piso
   for i=2, 5, 1 do
      for _, piso in ipairs(self.nivel[i]) do
	 if ( game:colisionRectangulos(objeto,piso) ) then
	    return true,piso
	 end
      end
   end
   return false
end

function game:actualizar(dt)
   for i=2, 5, 1 do
      for _, piso in ipairs(self.nivel[i]) do
	 piso:actualizar(dt)
      end
   end
end


function game:colisionRectangulos(rect1, rect2)
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

return game