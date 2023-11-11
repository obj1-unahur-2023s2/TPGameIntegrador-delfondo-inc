import elementos.*
import wollok.game.*
import interface.*
import sonido.*
import personajes.*
import teclasPinguinos.*
import movimientos.*

object juego {
	
	//Instancias de pinguinos siendo personajes y no. 
	/* 
	const property pinguinoVerdeCh = new Pinguino(position=game.at(9,1), direccion=abajo, color="Verde", esPersonaje=true)
	const property pinguinoRosa = new Pinguino(position=game.at(7,1), direccion=abajo, color="Rosa", esPersonaje=false)
	const property pinguinoRosaCh = new Pinguino(position=game.at(9,1), direccion=abajo, color="Rosa", esPersonaje=true)
	const property pinguinoVerde = new Pinguino(position=game.at(7,1), direccion=abajo, color="Verde", esPersonaje=false)
	*/
	//Acá cuando el jugador seleccione el pinguino, se guarda esa instancia que es personaje y la del otro pinguino que no lo es. 
	var property seleccionado //= //pinguinoVerdeCh
	var property noSeleccionado //= pinguinoRosa
	const enemigo = new Arania(position=game.at(6,7),direccion=abajo)
	
	method cargarPersonajes(p1,p2)
	{
		seleccionado=p1
		noSeleccionado=p2
		p1.imprimir()
		p2.imprimir()
	}
	
	method agregarEnemigos() {
		enemigo.imprimir()
		game.onTick(1000,"arañaMov", {=> enemigo.movete()})
		game.onTick(100,"arañaAtaque", {=> enemigo.atraparPinguino()})
	}
	
	method cargarControles(){
		//const nivel = new Nivel()
		//keyboard.t().onPressDo({nivel.construirNivel(interface.nivel1())}) 
		//keyboard.t().onPressDo({self.cargarPersonajes(p1,p2) self.agregarEnemigos()}) // Temporal
		//keyboard.y().onPressDo({gestorDeSonido.iniciar()}) // Temporal
		//keyboard.u().onPressDo({gestorDeSonido.alternar("daño.ogg")}) // Temporal
		//keyboard.i().onPressDo({gestorDeSonido.alternar("rebote.ogg")})
		//keyboard.p().onPressDo({gestorDeSonido.pausar()})
		controles.controlesPinguinos()
	}
	
	
	method ganar(){
		game.clear()
		game.addVisual("assets/prueba.png")
		gestorDeSonido.sonidoGanar()
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
	
	method girarPinguinos() {
		seleccionado.dateVuelta()
		noSeleccionado.dateVuelta()
	}
	//Golpes pinguinos
	method realizarAtaques() {
		self.animarGolpePinguinos()
		self.accionarGolpes()
		self.desanimarPinguinos()
	}
	method accionarGolpes() {
		const golpes = self.crearGolpesNecesarios()
		//const golpe1 = new Golpe(position=self.posicionarGolpePinguino(seleccionado),direccion=seleccionado.direccion())
		//const golpe2 = new Golpe(position=self.posicionarGolpePinguino(noSeleccionado),direccion=noSeleccionado.direccion())
		self.animarGolpePinguinos()
		self.agregarGolpes(golpes)
		self.eliminarEnemigos(golpes)
		//#{golpe1,golpe2}.forEach({g => g.eliminarEnemigos()})
		//self.removerGolpes(golpe1,golpe2)
		self.removerGolpes(golpes)
		self.desanimarPinguinos()
	}
	method animarGolpePinguinos() {
		seleccionado.estado("Pegando")
		noSeleccionado.estado("Pegando")
		seleccionado.animacionGolpes(seleccionado.direccion())
		noSeleccionado.animacionGolpes(noSeleccionado.direccion())
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
	method desanimarPinguinos() {
		game.schedule(200,{=> seleccionado.estado("Moviendo") noSeleccionado.estado("Moviendo")})
	}
	
	method crearGolpesNecesarios() {
		const golpes = []
		if(game.hasVisual(seleccionado)) {
			golpes.add(new Golpe(position=self.posicionarGolpePinguino(seleccionado),direccion=seleccionado.direccion()))
		}
		if(game.hasVisual(noSeleccionado)) {
			golpes.add(new Golpe(position=self.posicionarGolpePinguino(noSeleccionado),direccion=noSeleccionado.direccion()))
		}
		
		return golpes
	}
	
	method agregarGolpes(golpes) {
		golpes.forEach({g => game.addVisual(g)})
	}
	
	method eliminarEnemigos(golpes) {
		golpes.forEach({g => g.eliminarEnemigos()})
	}
	
	method removerGolpes(golpes) {
		game.schedule(200, {golpes.forEach({g => game.removeVisual(g)})})
	}
}

