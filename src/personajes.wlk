import wollok.game.*
import movimientos.*
import elementos.*
import juego.*
import tablero.*
class Personaje {
	var property position
	var direccion
	
	method direccion() = direccion
	method position() = position
	method image()
	method imprimir(){ game.addVisual(self) }
	
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
	var property esPersonaje = false
	var frame = 1
	
	method color()=color	
	override method image() = "pinguino" + color + estado + direccion.toString() + frame.toString() + ".png"
	// Esto es para que los pinguinos se puedan traspasar entre sí.
	override method puedePisarte(_) = true
	
	override method esEnemigo() = false
	
	method principal(){ esPersonaje = true }
	method noEsPrincipal(){ esPersonaje = false }
	// Movimientos parametrizados.
	method pasoEnX(direccionX) {
		if(esPersonaje) {
			direccion = direccionX
		}
		else {
			direccion = direccionX.opuesto()
		}
		estado = "Moviendo"
		self.validarLugarLibre(direccion.siguiente(position))
		position = direccion.siguiente(position)
		self.animacion(direccion)
	}
	
	method pasoEnY(direccionY) {
		direccion = direccionY
		estado = "Moviendo"
		self.validarLugarLibre(direccion.siguiente(position))
		position = direccion.siguiente(position)
		self.animacion(direccion)
	}
	
	method dateVuelta() {
		direccion = direccion.opuesto()
		frame = 1
	}
	//Animacion de movimiento-subir imagenes correspondientes hacia cada direccion del rosa-
		method animacion(dir){ 
			direccion = dir
			frame = 2
			game.schedule(250,{=> frame = 1})
		}
		
	method animacionGolpes(dir){
		direccion = dir
		game.schedule(250,{=> 
			estado ="Moviendo"
			frame = 1
		})
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
	
	var property image = "arania.png"
	var nombre
	
	override method esEnemigo() = true
	override method puedePisarte(_) = true
	method nombre() = nombre
	
	method movete() {
		
		direccion = [arriba,derecha,abajo,izquierda].anyOne()
		self.moverSiSePuedeA(direccion.siguiente(position))
	}
	override method eliminate() {
		tablero.sumarPuntaje(15)
		game.removeVisual(self)
		game.removeTickEvent(nombre + "1")
		game.removeTickEvent(nombre)
	}
	method atraparPinguino() {
		const objetosDeLaCelda = game.getObjectsIn(position).filter({o => o.image().startsWith("pinguino")})
		objetosDeLaCelda.forEach({o => o.eliminate()}) 
	}
	
	method moverSiSePuedeA(pos) {
		if(self.todosSonPisables(pos)) {
			position = pos
			self.animacion()
		}
	}
	
	method todosSonPisables(pos) = game.getObjectsIn(pos).all({o => o.puedePisarte(self)})
	
	method animacion(){ 
			self.image("arania.png")
			game.schedule(1000, {self.image("arania2.png")})
		}
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
