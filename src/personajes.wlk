import wollok.game.*
import movimientos.*

class Personaje {
	var position
	var direccion
	
	method direccion() = direccion
	
	method position() = position
	
	method pasoArriba(){
		position = direccion.siguiente(position)
	}
	
	method pasoDerecha(){
		position = direccion.siguiente(position)
	}
	
	method pasoAbajo(){
		position = direccion.siguiente(position)
	}
	
	method pasoIzquierda(){
		position = direccion.siguiente(position)
	}
	method hayObjetosEn(pos) = game.getObjectsIn(pos).size() > 0
}

class Pinguino inherits Personaje {
	const color
	var esPersonaje
	
	method image() = "pinguino" + color + direccion.toString() + ".png"
	
	override method pasoArriba() {
		direccion = arriba
		self.errorSiHayObjAl(direccion.siguiente(position))
		super()
	}
	override method pasoAbajo() {
		direccion = abajo
		self.errorSiHayObjAl(direccion.siguiente(position))
		super()
	}
	override method pasoDerecha() {
		if(esPersonaje) {
			direccion = derecha
			self.errorSiHayObjAl(direccion.siguiente(position))
			position.right(1)
		}
		else {
			direccion = izquierda
			self.errorSiHayObjAl(direccion.siguiente(position))
			position.left(1)
		}
	}
	override method pasoIzquierda() {
		if(esPersonaje) {
			direccion = izquierda
			self.errorSiHayObjAl(direccion.siguiente(position))
			position.left(1)
		}
		else {
			direccion = derecha
			self.errorSiHayObjAl(direccion.siguiente(position))
			position.right(1)
		}
	}

	method errorSiHayObjAl(pos) {
		if(self.hayObjetosEn(pos)) {
			throw new Exception(message = "No puedo moverme en esa direccion")
		}
	}
	
}


class Arania inherits Personaje {
	
}
