import elementos.*
import wollok.game.*
import interface.*

object juego
{
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
	
	method cargarColisiones(){
		
	}
	
	method cargarControles(){
		const nivel1 = new Nivel()
		keyboard.t().onPressDo({nivel1.construirNivel(nivel1.posicionesNivel1())})
	}
}
