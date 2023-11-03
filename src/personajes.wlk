import wollok.game.*
import movimientos.*
import elementos.*
import juego.*

class Personaje {
	var position
	var direccion
	
	method direccion() = direccion
	
	method position() = position
	
	method image()
	
	method eliminate()
	
	method esEnemigo()
	//Metodos de movimientos parametrizados
	
	//Para validar en las colisiones
	method puedePisarte(_)
	//method hayObjetosEn(pos) = game.getObjectsIn(pos).size() > 0
}

class Pinguino inherits Personaje {
	const color
	var property estado = "Parado"
	var property esPersonaje
	
	override method image() = "pinguino" + color + estado + direccion.toString() + ".png"
	
	
	// Esto es para que los pinguinos se puedan traspasar entre sí.
	override method puedePisarte(_) = true
	
	override method esEnemigo() = false
	
	// Movimientos parametrizados.
	method pasoEnX(direccionX) {
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
	
	method pasoEnY(direccionY) {
		direccion = direccionY
		self.validarLugarLibre(direccion.siguiente(position))
		estado = "Moviendo"
		position = direccion.siguiente(position)
	}
	
	method dateVuelta() {
		direccion = direccion.opuesto()
	}
	
	//Método para validaciones
	method validarLugarLibre(direccion) {
		const lugarLibre = game.getObjectsIn(direccion)
			.all{ obj => obj.puedePisarte(self) } 
		
		if (!lugarLibre) 
			self.error("No puedo ir para ese lado")
	}
	
	//Metodo para eliminar el pinguino, instanciando un pinguino atrapado en su lugar 
	override method eliminate() {
		game.addVisual(new PinguinoAtrapado(position=position,color=color,esPersonaje=esPersonaje,direccion=arriba))
		game.removeVisual(self)
	}
}

class Arania inherits Personaje {
	
	override method image() = "arania.png"
	override method esEnemigo() = true
	override method puedePisarte(_) = true
	
	method movete() {
		const numDir = [1,2,3,4].anyOne()
		
		if(numDir == 1) {
			direccion = arriba
		}
		if(numDir == 2) {
			direccion = derecha
		}
		if(numDir == 3) {
			direccion = abajo
		}
		if(numDir == 4) {
			direccion = izquierda
		}
		
		self.moverSiSePuedeA(direccion.siguiente(position))
	}
	override method eliminate() {
		game.removeVisual(self)
		game.removeTickEvent("arañaMov")
		game.removeTickEvent("arañaAtaque")
	}
	method atraparPinguino() {
		const objetosDeLaCelda = game.getObjectsIn(position).filter({o => o.image().startsWith("pinguino")})
		objetosDeLaCelda.forEach({o => o.eliminate()}) 
	}
	
	method moverSiSePuedeA(pos) {
		if(self.todosSonPisables(pos)) {
			position = pos
		}
	}
	
	method todosSonPisables(pos) = game.getObjectsIn(pos).all({o => o.puedePisarte(self)})
}

class PinguinoAtrapado inherits Personaje {
	const color
	const esPersonaje
	override method image() = "telaraniaPingu" + color + ".png"
	override method esEnemigo() = true
	override method puedePisarte(_) = true
	override method eliminate() {
		const pinguino = new Pinguino(position=position,direccion=abajo,color=color,esPersonaje=esPersonaje)
		game.removeVisual(self)
		game.schedule(200, {=> if(esPersonaje) {
			juego.seleccionado(pinguino)
			game.addVisual(juego.seleccionado())
		}
		else {
			juego.noSeleccionado(pinguino)
			game.addVisual(juego.noSeleccionado())
		}})
	}
}
