import wollok.game.*
import personajes.*
import juego.*

object corazon {
	var cerrado = true
	
	method image() = if(cerrado) "kokoro.png" else "kokoro2.png"
	method position() = game.at(8,10)
	method puedePisarte(_) = true
	method esEnemigo() = false	
	method abrir(){ cerrado = false }
}

class Pared {
	method image() = "assets/pared.png"
	method puedePisarte(_) = false
	method esEnemigo() = false
}

class Bloque {
	method image() = "assets/bloque.png"
	method puedePisarte(_) = false
	method esEnemigo() = false
}

class Telarana {
	var position
	
	method image() = "assets/telarania.png"
	method puedePisarte(_) = true
	method esEnemigo() = true
	method eliminate() {
		game.removeVisual(self)}
	method atraparPinguino() {
		const objetosDeLaCelda = game.getObjectsIn(position).filter({o => o.image().startsWith("pinguino")})
		objetosDeLaCelda.forEach({o => o.eliminate()}) 
	}
}
 //Las instancias de los golpes de los pinguinos
class Golpe {
	const direccion
	const position
	
	method position() = position
	method image() = "golpe" + direccion.toString() + ".png"
	method esEnemigo() = false
	method puedePisarte(_) = true
	method eliminate() {}
	method eliminarEnemigos() {
		const objetosEnemigos = game.getObjectsIn(position).filter({o => o.esEnemigo()})
		objetosEnemigos.forEach({e =>e.eliminate()})
	}
}