local M = {}
M.tuboDer = 0
M.tuboIzq = 0

function M.cargarTuberiaDer()
   M.tuboDer =
      love.graphics.newImage("img/tiles/tuberia_derecha.png")
end

function M.cargarTuberiaIzq()
   M.tuboIzq = 
      love.graphics.newImage("img/tiles/tuberia_izquierda.png")
end

function M.cargarBloque()
   M.bloque = 
      love.graphics.newImage("img/tiles/bloque.png")
end

return M
