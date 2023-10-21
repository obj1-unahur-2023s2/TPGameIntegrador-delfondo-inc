import elementos.*
import wollok.game.*
import interface.*
import sonido.*

object juego {
	method start(){
		self.cargarPantalla()
		self.cargarPersonajes()
		self.cargarColisiones()
		self.cargarControles()
	}
	
	method cargarPantalla(){
		game.width(17)
		game.height(13)
		game.cellSize(64)
		game.boardGround("empedrado.jpg")
		
		//interface.cargarNivel(inicial)
	}
	
	method cargarPersonajes(){
		game.addVisualCharacter(auto)
	}
	
	method cargarColisiones() {}
	
	method cargarControles(){
		const nivel1 = new Nivel()
		keyboard.t().onPressDo({nivel1.construirNivel(nivel1.posicionesNivel1())}) // Temporal
		keyboard.y().onPressDo({gestorDeSonido.iniciar()}) // Temporal
		keyboard.u().onPressDo({gestorDeSonido.alternar("daño.ogg")}) // Temporal
		keyboard.i().onPressDo({gestorDeSonido.alternar("rebote.ogg")})
		keyboard.p().onPressDo({gestorDeSonido.pausar()})
	}
}
