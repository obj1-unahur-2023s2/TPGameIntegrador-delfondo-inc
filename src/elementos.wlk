import wollok.game.*
import personajes.*

object corazon {
	var cerrado = true
	
	method image() = if(cerrado) "" else ""
	method abrir(){ cerrado = false }
}

class Pared {
	method image() = "ladrilloPrueba.png"
}

class Telarana {}
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