import wollok.game.*
import movimientos.*

class Personaje {
	var position = game.at(x,y)
	var direccion = arriba
	var x
	var y
	
	method position() = position
	
	method pasoArriba(){
		position = position.up(1)
	}
	
	method pasoDerecha(){
		position = position.right(1)
	}
	
	method pasoAbajo(){
		position = position.down(1)
	}
	
	method pasoIzquierda(){
		position = position.left(1)
	}
	method hayObjetosEn(pos) = game.getObjectsIn(pos).size() > 0
}

class Pinguino inherits Personaje {
	const color
	var property esPersonaje

	method image() = "pinguino" + color + direccion.toString() + ".png"
	
	override method pasoArriba() {
		direccion = arriba
		self.errorSiHayObjAl(direccion.siguiente())
		super()
	}
	override method pasoAbajo() {
		direccion = abajo
		self.errorSiHayObjAl(direccion.siguiente())
		super()
	}
	override method pasoDerecha() {
		if(esPersonaje) {
			direccion = derecha
			self.errorSiHayObjAl(direccion.siguiente())
			position.right(1)
		}
		else {
			direccion = izquierda
			self.errorSiHayObjAl(direccion.siguiente())
			position.left(1)
		}
	}
	override method pasoIzquierda() {
		if(esPersonaje) {
			direccion = izquierda
			self.errorSiHayObjAl(direccion.siguiente())
			position.left(1)
		}
		else {
			direccion = derecha
			self.errorSiHayObjAl(direccion.siguiente())
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
