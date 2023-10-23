import wollok.game.*
import movimientos.*

class Personaje {}

class Pinguino inherits Personaje {
	var property position
	var property image = "pinguino" + direccion.toString() + ".png"
	var direccion = arriba
	var esPersonaje = false
	
	method subir() {
		direccion = arriba
		self.errorSiHayObjAl(direccion.siguiente())
		position.up(1)
	}
	method bajar() {
		self.errorSiHayObjAl(position.get(1) + 1)
		position.down(1)
	}
	method moverDer() {
		if(esPersonaje) {
			self.errorSiHayObjAl(position.get(0) + 1)
			position.right(1)
		}
		else {
			self.errorSiHayObjAl(position.get(0) - 1)
			position.left(1)
		}
	}
	method moverIzq() {
		if(esPersonaje) {
			self.errorSiHayObjAl(position.get(0) - 1)
			position.left(1)
		}
		else {
			self.errorSiHayObjAl(position.get(0) + 1)
			position.right(1)
		}
	}
	method esPersonaje() = esPersonaje
	
	method volverPersonaje() {
		esPersonaje = true
	}
	method errorSiHayObjAl(pos) {
		if(self.hayObjetosEn(pos)) {
			throw new Exception(message = "No puedo moverme en esa direccion")
		}
	}
	method hayObjetosEn(pos) = game.getObjectsIn(pos).size() > 0
}
