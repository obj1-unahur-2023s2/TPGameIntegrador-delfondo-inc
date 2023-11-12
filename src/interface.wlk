import wollok.game.*
import elementos.*
import juego.*
import sonido.*
import movimientos.*
import personajes.*
import tablero.*

object gestorNiveles{
	var property nivelActualNumero = 1
	var property nivelActual = nivel1
	
	method ultimoNivel() = self.nivelActual().siguienteNivel() == null
	
	method cargarSiguienteNivel(){
		if(!self.ultimoNivel()){
			nivelActual = nivelActual.siguienteNivel()
			nivelActualNumero++
			gestorDeSonido.pararMusica()
			corazon.cerrar()
			nivelActual.iniciar(new Pinguino(position=game.at(9,1), direccion=abajo, color="Verde", esPersonaje=true), new Pinguino(position=game.at(7,1), direccion=abajo, color="Rosa", esPersonaje=false))	
		}
		else{
			juego.ganar()
		}
	}
}

class Nivel {
	const nombre
	var property siguienteNivel = null
	var property bloques = []
	var property corazonGanador = null
	var property telaranias = []
	var property aranias = []
	var elementos = []
	
	method elementos() = elementos
	
	method posicionX(registro) = registro.first()
	method posicionY(registro) = registro.last()
	method agregarPared(ubicacion){
		game.addVisualIn(new Pared(), game.at(self.posicionX(ubicacion),self.posicionY(ubicacion)))
	}
	method agregarBloque(ubicacion){
		game.addVisualIn(new Bloque(), game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}
	method agregarCorazon(ubicacion){
		game.addVisualIn(corazon, game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
		game.onTick(3000,"verificarCorazon", {=> corazon.verificar()})
	}
	method agregarTelarania(ubicacion){
		const telarania = new Telarana(position = game.at(self.posicionX(ubicacion),self.posicionY(ubicacion)))
		juego.agregarTelaranias(telarania)
	}
	method agregarArania(ubicacion){
		const arania = new Arania(position = game.at(self.posicionX(ubicacion),self.posicionY(ubicacion)),direccion=abajo)
		juego.agregarEnemigos(arania)
	}
	method construirNivel(){
		game.clear()
		const marco = []
		
		(0..16).forEach({ i => marco.add([i,0]) })
		(1..11).forEach({ i => marco.add([0,i]) })
		(1..16).forEach({ i => marco.add([i,11]) })
		(1..10).forEach({ i => marco.add([16,i]) })
		bloques.forEach({ubicacion=>self.agregarBloque(ubicacion)})
		marco.forEach({ubicacion=>self.agregarPared(ubicacion)})
		telaranias.forEach({ubicacion=>	self.agregarTelarania(ubicacion)})
		aranias.forEach({ubicacion=> self.agregarArania(ubicacion)})								
		self.agregarCorazon(corazonGanador)
	}
	
	method iniciar(per1,per2) 
	{
		game.clear()
		gestorDeSonido.sonidoJuego()
		self.construirNivel()
		tablero.nivelDato(nombre)
		tablero.iniciar()
		juego.cargarPersonajes(per1,per2)
		juego.cargarControles()
		self.volverAlMenu()
	}
	
	method volverAlMenu(){
		keyboard.m().onPressDo{menu.cargar() gestorDeSonido.pararMusica()}
	}
}

object menu 
{
    var property image= "menugurin.png"
    var property opciones=["menugurin.png","menumalon.png","menucontrol.png","menusalir.png"]

    var seleccion = 0
    var property position= game.at(0,0)
    method cargar()
    {
        game.clear()
        game.addVisual(self)
        keyboard.up().onPressDo{ self.subir() }
        keyboard.down().onPressDo{ self.bajar() }
        keyboard.enter().onPressDo{ self.seleccionar() }
    }

    method subir()
    {
        self.anterior(seleccion)
        self.image(self.opciones().get(seleccion))
        gestorDeSonido.sonidoCursor()
    }

    method bajar()
    {
        self.siguiente(seleccion)
        self.image(self.opciones().get(seleccion))
        gestorDeSonido.sonidoCursor()
    }

    method seleccionar()
    {
        const rosa =  new Pinguino(position=game.at(7,1), direccion=abajo, color="Rosa")
        const verde = new Pinguino(position=game.at(9,1), direccion=abajo, color="Verde")

        if (seleccion == 0)
        { 
            verde.principal()
            nivel1.iniciar(verde,rosa)
        } else
        if (seleccion == 1)
        { 
            rosa.principal() 
            nivel1.iniciar(rosa, verde)
        } else
        if (seleccion == 2){ control.cargar() }
        else { game.stop() }
    }
	
	method siguiente(num){ if(num == 3) { seleccion = 0 } else { seleccion += 1 } }
	method anterior(num){ if(num == 0) { seleccion = 3 } else { seleccion -= 1 } }
}

object control{
	var property image= "control.png"
	var property position= game.at(0,0)
	method cargar()
	{
		game.addVisual(self)
		gestorDeSonido.sonidoControles()
		keyboard.m().onPressDo{ menu.cargar() gestorDeSonido.pararMusica() }
	}
}


const nivel1 = new Nivel(
	nombre = "nivel1",
	siguienteNivel = nivel2,
	bloques = [ [1,4],[1,8],[2,2],[2,4],[2,6],[2,8],[2,9],[3,2],[3,6],[3,9],
				[4,2],[4,4],[4,6],[4,8],[4,9],[5,2],[5,6],[6,2],[6,4],[6,6],
				[6,8],[6,9],[7,2],[7,9],[8,1],[8,2],[8,3],[8,4],[8,5],[8,6],
				[8,7],[8,8],[8,9],[9,2],[9,8],[10,2],[10,4],[10,6],[10,8],[10,9],
				[11,2],[11,6],[11,9],[12,2],[12,4],[12,6],[12,8],[12,9],[13,2],[13,6],
				[14,2],[14,4],[14,6],[14,8],[14,9],[15,4],[15,9]],
	corazonGanador = [8,10],
	telaranias = null,
	aranias = [[6,7]]
)

const nivel2 = new Nivel(
	nombre = "nivel2",
	siguienteNivel = nivel3,
	bloques = [	[1,4],[2,2],[2,4],[2,6],[2,8],[2,9],[3,6],[4,2],[4,3],[4,4],
				[4,6],[4,7],[4,8],[4,9],[5,4],[6,1],[6,2],[6,4],[6,6],[6,8],
				[6,9],[7,6],[7,9],[8,1],[8,2],[8,3],[8,4],[8,5],[8,6],[8,7],
				[8,8],[8,9],[9,2],[9,6],[9,9],[10,2],[10,4],[10,6],[10,8],[10,9],
				[11,4],[11,8],[12,2],[12,4],[12,6],[12,7],[12,8],[12,9],[13,4],[13,8],
				[14,2],[14,4],[14,6],[14,8],[14,9],[15,2],[15,6]],
	corazonGanador = [8,10],
	telaranias = [[1,3],[1,7],[3,5],[7,7],[9,5],[15,7]],
	aranias = [[6,7],[10,5]]
)

const nivel3 = new Nivel(
	nombre = "nivel3",
	siguienteNivel = null,
	bloques = [	[2,1],[2,2],[2,3],[2,4],[2,6],[2,7],[2,8],[2,9],[3,6],[4,2],
		[4,3],[4,4],[4,5],[4,6],[4,8],[4,9],[4,10],[5,6],[6,1],[6,2],[6,3],
		[6,4],[6,6],[6,7],[6,8],[6,9],[7,6],[8,1],[8,2],[8,3],[8,4],[8,5],
		[8,6],[8,7],[8,8],[8,9],[9,4],[10,2],[10,4],[10,6],[10,8],[10,9],[11,6],
		[12,2],[12,3],[12,4],[12,6],[12,7],[12,8],[12,9],[13,4],[14,1],[14,2],[14,4],
		[14,6],[14,8],[14,9],[15,6],[15,9]],
	corazonGanador = [8,10],
	telaranias = [[1,3],[1,7],[1,8],[1,9],[2,5],[3,2],[3,8],[5,5],[5,10],[7,8],
				 [9,3],[9,7],[11,5],[14,3],[15,7]],
	aranias = null
)