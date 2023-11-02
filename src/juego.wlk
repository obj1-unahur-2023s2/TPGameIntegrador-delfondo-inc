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
	
	method cargarPersonajes() {
		game.addVisual(pinguinoVerdeCh)
		game.addVisual(pinguinoRosa)
	}
	method cargarColisiones() {}
	
	method cargarControles(){
		const nivel = new Nivel()
		keyboard.t().onPressDo({nivel.construirNivel(interface.nivel1())}) 
		keyboard.t().onPressDo({self.cargarPersonajes()}) // Temporal
		keyboard.y().onPressDo({gestorDeSonido.iniciar()}) // Temporal
		keyboard.u().onPressDo({gestorDeSonido.alternar("daño.ogg")}) // Temporal
		keyboard.i().onPressDo({gestorDeSonido.alternar("rebote.ogg")})
		keyboard.p().onPressDo({gestorDeSonido.pausar()})
	}
	
	method ganar(){
		game.clear()
		// imagenGanadora.mostrar()
		gestorDeSonido.ganar()
		game.schedule(10000,{game.stop()})
	}
	
	method perder(){
		game.clear()
		// imagenPerdedora.mostrar()
		game.schedule(10000,{game.stop()})
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
	method realizarAtaques() {
		self.animarGolpePinguinos()
		self.accionarGolpes()
		self.desanimarPinguinos()
	}
	method accionarGolpes() {
		const golpe1 = new Golpe(position=self.posicionarGolpePinguino(seleccionado),direccion=seleccionado.direccion())
		const golpe2 = new Golpe(position=self.posicionarGolpePinguino(pinguinoRosa),direccion=pinguinoRosa.direccion())
		game.addVisual(golpe1)
		game.addVisual(golpe2)
		self.animarGolpePinguinos()
		#{golpe1,golpe2}.forEach({g => g.eliminarEnemigos()})
		self.removerGolpes(golpe1,golpe2)
		self.desanimarPinguinos()
	}
	
	//Golpes pinguinos
	method animarGolpePinguinos() {
		seleccionado.estado("Pegando")
		pinguinoRosa.estado("Pegando")
	}
	
	method posicionarGolpePinguino(pinguino) {
		return if(pinguino.direccion().toString() == "arriba") {
			game.at(pinguino.position().x(), pinguino.position().y() + 1) 
		}
		else if(pinguino.direccion().toString() == "abajo"){
			game.at(pinguino.position().x(), pinguino.position().y() - 1) 
		}
		else if(pinguino.direccion().toString() == "derecha") {
			game.at(pinguino.position().x() + 1, pinguino.position().y()) 
		}
		else {
			game.at(pinguino.position().x() - 1, pinguino.position().y()) 
		}
	}
	method removerGolpes(golpe1,golpe2) {
		game.schedule(200, {=> game.removeVisual(golpe1) game.removeVisual(golpe2)})
	}
	method desanimarPinguinos() {
		game.schedule(200,{=> seleccionado.estado("Moviendo") pinguinoRosa.estado("Moviendo")})
	}
}
