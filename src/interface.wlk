import wollok.game.*
import elementos.*
import juego.*
import sonido.*
import movimientos.*
import personajes.*

object gestorNiveles{
	var property nivelActualNumero = 1
	var property nivelActual = nivel1
	
	method ultimoNivel() = self.nivelActual().siguienteNivel() == null
	
	method cargarSiguienteNivel(){
		if(!self.ultimoNivel()){
			nivelActual = nivelActual.siguienteNivel()
			nivelActualNumero++
			nivelActual.iniciar(new Pinguino(position=game.at(9,1), direccion=abajo, color="Verde", esPersonaje=true), new Pinguino(position=game.at(7,1), direccion=abajo, color="Rosa", esPersonaje=false))	
		}
		else{
			//juego.ganar()
		}
	}
}

class Nivel {
	var property siguienteNivel = null
	var property paredes = []
	var property corazonGanador = null
	var property telaranias = []
	var property aranias = []
	
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
	}
	method agregarTelarania(ubicacion){
		game.addVisualIn(new Telarana(position = game.at(self.posicionX(ubicacion),self.posicionY(ubicacion))), game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}
	method construirNivel(){
		game.clear()
		const marco = []
		
		(0..16).forEach({ i => marco.add([i,0]) })
		(1..11).forEach({ i => marco.add([0,i]) })
		(1..16).forEach({ i => marco.add([i,11]) })
		(1..10).forEach({ i => marco.add([16,i]) })
		paredes.forEach({ubicacion=>self.agregarPared(ubicacion)})
		marco.forEach({ubicacion=>self.agregarBloque(ubicacion)})
		telaranias.forEach({ubicacion=>self.agregarTelarania(ubicacion)})
		self.agregarCorazon(corazonGanador)
	}
	
	method iniciar(per1,per2) {
		gestorDeSonido.sonidoJuego()
		self.construirNivel()
		juego.cargarPersonajes(per1,per2)
		juego.agregarEnemigos()
		juego.cargarControles()
		self.volverAlMenu()
	}
	
	method volverAlMenu(){
		keyboard.m().onPressDo{menu.cargar() gestorDeSonido.pararMusica()}
	}
}

object menu {
	var property image= "menugurin.png"
	var property opciones=["menugurin.png","menumalon.png","menucontrol.png","menusalir.png"]
	const property position= game.at(0,0)
	
	method cargar(){
		game.clear()
		game.addVisual(self)
		game.addVisual(selector)
		keyboard.up().onPressDo{selector.subir()}
		keyboard.down().onPressDo{selector.bajar()}
		keyboard.enter().onPressDo{selector.seleccionar()}
	}
}

object control{
	var property image= "control.png"
	var property position= game.at(0,0)
	method cargar(){
		game.addVisual(self)
		gestorDeSonido.sonidoControles()
		keyboard.m().onPressDo{menu.cargar() gestorDeSonido.pararMusica()
		}
	}
}

object selector{
	var property posImagen=0
	var property position= game.at(0,7)
	
	method subir(){
		if (self.position().y()<7) {position=position.up(2) posImagen=0.max(posImagen-1) menu.image(menu.opciones().get(posImagen))gestorDeSonido.sonidoCursor() }
	}
	method bajar(){
		if (self.position().y()>1) {position=position.down(2) posImagen=posImagen+1 menu.image(menu.opciones().get(posImagen))gestorDeSonido.sonidoCursor()}
	}
	method seleccionar(){
		if (self.position().y()==7){nivel1.iniciar(new Pinguino(position=game.at(9,1), direccion=abajo, color="Verde", esPersonaje=true), new Pinguino(position=game.at(7,1), direccion=abajo, color="Rosa", esPersonaje=false))}
		if (self.position().y()==5){nivel1.iniciar(new Pinguino(position=game.at(7,1), direccion=abajo, color="Rosa", esPersonaje=true), new Pinguino(position=game.at(9,1), direccion=abajo, color="Verde", esPersonaje=false))}
		if (self.position().y()==3){control.cargar()}
		if (self.position().y()==1){game.stop()}
	}
}


const nivel1 = new Nivel(
	siguienteNivel = nivel2,
	paredes = [ [1,4],[1,8],[2,2],[2,4],[2,6],[2,8],[2,9],[3,2],[3,6],[3,9],
				[4,2],[4,4],[4,6],[4,8],[4,9],[5,2],[5,6],[6,2],[6,4],[6,6],
				[6,8],[6,9],[7,2],[7,9],[8,1],[8,2],[8,3],[8,4],[8,5],[8,6],
				[8,7],[8,8],[8,9],[9,2],[9,8],[10,2],[10,4],[10,6],[10,8],[10,9],
				[11,2],[11,6],[11,9],[12,2],[12,4],[12,6],[12,8],[12,9],[13,2],[13,6],
				[14,2],[14,4],[14,6],[14,8],[14,9],[15,4],[15,9]],
	corazonGanador = [8,10],
	telaranias = null,
	aranias = [6,7]
)

const nivel2 = new Nivel(
	siguienteNivel = nivel3,
	paredes = [	[1,4],[2,2],[2,4],[2,6],[2,8],[2,9],[3,6],[4,2],[4,3],[4,4],
				[4,6],[4,7],[4,8],[4,9],[5,4],[6,1],[6,2],[6,4],[6,6],[6,8],
				[6,9],[7,6],[7,9],[8,1],[8,2],[8,3],[8,4],[8,5],[8,6],[8,7],
				[8,8],[8,9],[9,2],[9,6],[9,9],[10,2],[10,4],[10,6],[10,8],[10,9],
				[11,4],[11,8],[12,2],[12,4],[12,6],[12,7],[12,8],[12,9],[13,4],[13,8],
				[14,2],[14,4],[14,6],[14,8],[14,9],[15,2],[15,6]],
	corazonGanador = [8,10],
	telaranias = [[1,3],[1,7],[3,5],[7,7],[9,5],[15,7]],
	aranias = [[6,7],[6,8]]
	
)

const nivel3 = new Nivel(
	siguienteNivel = null,
	paredes = null,
	corazonGanador = [8,10],
	telaranias = null,
	aranias = null
)