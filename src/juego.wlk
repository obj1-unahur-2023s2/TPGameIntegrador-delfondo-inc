import elementos.*
import wollok.game.*
import interface.*
import sonido.*
import personajes.*
import teclasPinguinos.*
import movimientos.*

object juego {
	//Instancias de pinguinos siendo personajes y no. 
	const property pinguinoVerdeCh = new Pinguino(position=game.at(8,10), direccion=abajo, color="Verde", esPersonaje=true)
	const property pinguinoRosa = new Pinguino(position=game.at(6,10), direccion=abajo, color="Rosa", esPersonaje=false)
	const property pinguinoRosaCh = new Pinguino(position=game.at(8,10), direccion=abajo, color="Rosa", esPersonaje=true)
	const property pinguinoVerde = new Pinguino(position=game.at(6,10), direccion=abajo, color="Verde", esPersonaje=false)
	//Acá cuando el jugador seleccione el pinguino, se guarda esa instancia que es personaje y la del otro pinguino que no lo es. 
	var seleccionado
	var noSeleccionado
	
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
	
	//Manejo de excepciones de movimientos. Por ahora lo pongo acá
	method moverPinguinosEnX(direccionX) {
		try {
			noSeleccionado.pasoEnX(direccionX) 
			seleccionado.pasoEnX(direccionX)
		}
		catch e {
			seleccionado.pasoEnX(direccionX) 
		}
	}
	method moverPinguinosEnY(direccionY) {
		try {
			noSeleccionado.pasoEnY(direccionY)
			seleccionado.pasoEnY(direccionY)
		}
		catch e {
			seleccionado.pasoEnY(direccionY)
		}
	}
}
