-- Local Variables:
-- eval: (rename-buffer "billRender")
-- end:

local Bill = {
   izquierda = 0,
   derecha   = 0,
}

-- Método Estático --
function Bill.cargarSprites()
   Bill.izquierda = love.graphics.newImage("img/bill/izquierda.png")
   Bill.derecha = love.graphics.newImage("img/bill/derecha.png")
   Bill.noqueado = love.graphics.newImage("img/bill/noqueado.png")
end

function Bill.new()
   local o = game.render.Animacion.new()
   a=Bill
   if ( a.izquierda == 0 ) then a.cargarSprites() end
   o._izquierda    = newAnimation(a.izquierda,24,38,0.1,0)
   o._derecha      = newAnimation(a.derecha,24,38,0.1,0)
   o._noqueado     = newAnimation(a.noqueado,58,60,0.1,0)
   o._noqueado:setMode("once")
   o.actual=o._derecha
   
   return o
end

return Bill