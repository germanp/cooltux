-- Posibles direcciones
IZQUIERDA=-1
DERECHA=1

MAXWIDTH=800
MAXHEIGHT=600

function love.load()
   game=require('game')
   game.crearPersonajes({"Bill","Bill","Bill"})
end

function love.draw()
   for i,malo in ipairs(game.malos) do
      malo:dibujar()
   end
   for i=1, 6, 1 do
      for _, malo in ipairs(game.nivel[i].malos) do
	 malo:dibujar(dt)
      end
   end
   game:dibujar()
   game.jugador:dibujar()

end

function love.update(dt)
   game.jugador:actualizar(dt)
   game.dosificarMalos(dt)
   game:actualizar(dt)
   for i=1, 6, 1 do
      for _, malo in ipairs(game.nivel[i].malos) do
	 malo:actualizar(dt)
      end
   end
end

function love.keypressed(k)
   if k=="escape" then love.event.quit() end
end