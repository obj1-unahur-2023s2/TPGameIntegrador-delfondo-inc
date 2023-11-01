import wollok.game.*
import personajes.*

object corazon {
	var cerrado = true
	
	method image() = if(cerrado) "kokoro.png" else "kokoro2.png"
	method position() = game.at(8,10)
	
	method abrir(){ cerrado = false }
}

class Pared {
	method image() = "prueba1.png"
}

class Bloque {
	method image() = "prueba3.png"
}

class Telarana {
	method image() = "prueba2.png"
}
 //Las instancias de los golpes de los pinguinos
class Golpe {
	const property position
	const direccion
	method image() = "golpe" + direccion.toString() + ".png"
	method esEnemigo() = false
	method puedePisarte(_) = true
	method eliminarEnemigos() {
		const objetosEnemigos = game.getObjectsIn(position).filter({o => o.esEnemigo()})
		objetosEnemigos.forEach({e => game.removeVisual(e)})
	}
}