     ESPESOR_BLOQUES=1/30-- El espesor de los bloques \
     --  "cabezeables"
     ESPESOR_PISO=1/10   -- Espesor del piso de mas abajo.
     DIST_BLOQUES=1/6    -- Distancia vertical del piso al próximo
     --  bloque.
     LONG_BLOQUE1=1/8    -- Longitud de los bloques mas
     --  pequeños. Además coincide con las
     --  tuberías de abajo.
     LONG_BLOQUE2=3/8    -- Longitud de los bloques inferiores.
     LONG_BLOQUE3=7/16   -- Longitud de los bloques superiores.
     LONG_BLOQUE4=1/2    -- Longitud del bloque central
     
     o.piso={
	game.model.Rectangulo.new( -- Piso de abajo de todo
	 0,
	 alto,
	 ancho,
	 math.floor(alto*ESPESOR_PISO)
		      )
     }
     
     local dist_entre_bloques=DIST_BLOQUES*alto
     local espesor_bloques=math.floor(alto*ESPESOR_BLOQUES)
     local ancho_bloque = ancho*LONG_BLOQUE2
     local y = o.piso[1].y - dist_entre_bloques
     o.piso[2]= game.model.Rectangulo.new(
     	0,
     	y,
     	ancho_bloque,
     	espesor_bloques

     			      )
     o.piso[3]= game.model.Rectangulo.new(
     	ancho - ancho_bloque,
     	y,
     	ancho_bloque,
     	espesor_bloques
     			      )
     y = y - dist_entre_bloques - espesor_bloques
     o.piso[4]= game.model.Rectangulo.new(
     	math.floor(ancho/4),
     	y,
     	math.floor(ancho*LONG_BLOQUE4),
     	espesor_bloques
     			      )
     ancho_bloque = math.floor(ancho*LONG_BLOQUE1)
     y = y + espesor_bloques
     o.piso[5]= game.model.Rectangulo.new(
     	 0,
     	 y,
     	 ancho_bloque,
     	 espesor_bloques
					 )
     o.piso[6]= game.model.Rectangulo.new(
     	 ancho - ancho_bloque,
     	 y,
     	 ancho_bloque,
     	 espesor_bloques
			      )
     ancho_bloque = LONG_BLOQUE3*ancho
     y = y - dist_entre_bloques - espesor_bloques*2
     o.piso[7]= game.model.Rectangulo.new(
     	 0,
     	 y,
     	 ancho_bloque,
     	 espesor_bloques
     			      )
     o.piso[8]= game.model.Rectangulo.new(
     	ancho - ancho_bloque,
     	y,
     	ancho_bloque,
     	espesor_bloques
     			      )
