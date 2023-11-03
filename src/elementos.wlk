import wollok.game.*
import personajes.*
import juego.*

object corazon {
	var cerrado = true
	
	method image() = if(cerrado) "kokoro.png" else "kokoro2.png"
	method position() = game.at(8,10)
	method puedePisarte(_) = false
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
	method image() = "assets/telarania.png"
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