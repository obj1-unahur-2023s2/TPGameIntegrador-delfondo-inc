import elementos.*
import wollok.game.*
import interface.*
import sonido.*
import personajes.*
import teclasPinguinos.*
import movimientos.*

object juego {
	//Acá cuando el jugador seleccione el pinguino, se guarda esa instancia que es personaje y la del otro pinguino que no lo es. 
	var property seleccionado //= //pinguinoVerdeCh
	var property noSeleccionado //= pinguinoRosa
	var seleccion
	var seleccion2
    
    method seleccion(){
    	return new Pinguino(position=seleccion, direccion=abajo, color=seleccionado.color())
    }
     method seleccion2(){
    	return new Pinguino(position=seleccion2, direccion=abajo, color=noSeleccionado.color())
    }
method cargarPersonajes(p1,p2)
    {
        seleccionado=p1
        noSeleccionado=p2
        p1.imprimir()
        p2.imprimir()
    }
	method guardarSeleccion(smt1,smt2){
		seleccion=smt1.position()
		seleccion2=smt2.position()
	}
	method agregarEnemigos(enemigo) {
        enemigo.imprimir()
        game.onTick(800,enemigo.nombre() + "1", {=> enemigo.movete()})
        game.onTick(100,enemigo.nombre(), {=> enemigo.atraparPinguino()})
        game.onTick(2000, "Perder",{self.perder()})
    }
    
    method agregarTelaranias(telarania) {
    	telarania.imprimir()
    	game.onTick(100,telarania.nombre(), {=> telarania.atraparPinguino()})
    }
	
	method cargarControles(){
		controles.controlesPinguinos()
	}
	
    
	 method volverAlMenu(){
        keyboard.m().onPressDo{ menu.cargar() gestorDeSonido.pararMusica() }
    }

    method estanAtrapados()= !game.allVisuals().any({o => o.image().startsWith("pinguino")})//


    method pasarDeNivel(){
        gestorDeSonido.pararMusica()
        gestorDeSonido.sonidoGanar()
        game.schedule(4100,{gestorNiveles.cargarSiguienteNivel()})
    }

    method ganar(){
        game.clear()
        imagenGanadora.mostrar()
        self.volverAlMenu()

    }

    method perder(){
        if(self.estanAtrapados()){
        game.clear()
        gestorDeSonido.pararMusica()
        imagenPerdedora.mostrar()
        gestorDeSonido.sonidoPerder()
        self.volverAlMenu()
        }
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

