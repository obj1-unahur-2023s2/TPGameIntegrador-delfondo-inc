import wollok.game.*
import movimientos.*
import elementos.*

class Personaje {
	var position
	var direccion
	
	method direccion() = direccion
	
	method position() = position
	
	//Metodos de movimientos parametrizados
	
	method pasoEnX(direccionX)
	
	method pasoEnY(direccionY)
	
	//Por ahora esto está comentado
	/*
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
	*/
	
	//Para validar en las colisiones
	method puedePisarte(_)
	//method hayObjetosEn(pos) = game.getObjectsIn(pos).size() > 0
}

class Pinguino inherits Personaje {
	const color
	var property estado = "Parado"
	var property esPersonaje
	
	method image() = "pinguino" + color + direccion.toString() + ".png"
	
	
	// Esto es para que los pinguinos se puedan traspasar entre sí.
	override method puedePisarte(_) = true
	
	
	// Movimientos parametrizados.
	override method pasoEnX(direccionX) {
		if(esPersonaje) {
			direccion = direccionX
			self.validarLugarLibre(direccion.siguiente(position))
		}
		else {
			direccion = direccionX.opuesto()
			self.validarLugarLibre(direccion.siguiente(position))
		}
		estado = "Moviendo"
		position = direccion.siguiente(position)
	}
	
	override method pasoEnY(direccionY) {
		direccion = direccionY
		self.validarLugarLibre(direccion.siguiente(position))
		estado = "Moviendo"
		position = direccion.siguiente(position)
	}
	
	//Esto también queda cometnado por ahora
	/*
	override method pasoArriba() {
		direccion = arriba
		self.validarLugarLibre(direccion.siguiente(position))
		super()
	}
	override method pasoAbajo() {
		direccion = abajo
		self.validarLugarLibre(direccion.siguiente(position))
		super()
	}
	override method pasoDerecha() {
		if(esPersonaje) {
			direccion = derecha
			self.validarLugarLibre(direccion.siguiente(position))
			super()
		}
		else {
			direccion = izquierda
			self.validarLugarLibre(direccion.siguiente(position))
			super()
		}
	}
	override method pasoIzquierda() {
		if(esPersonaje) {
			direccion = izquierda
			self.validarLugarLibre(direccion.siguiente(position))
			super()
		}
		else {
			direccion = derecha
			self.validarLugarLibre(direccion.siguiente(position))
			super()
		}
	}
	*/
	
	//Método para validaciones
	method validarLugarLibre(direccion) {
		const lugarLibre = game.getObjectsIn(direccion)
			.all{ obj => obj.puedePisarte(self) } 
		
		if (!lugarLibre) 
			self.error("No puedo ir para ese lado")
	}
	
}



class Arania inherits Personaje {
	
}
