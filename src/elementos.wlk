import wollok.game.*
import personajes.*
import juego.*
import interface.*
import tablero.*
class Visual
{
	method imprimir(){ game.addVisual(self) } 
	method puedePisarte(_) = false
	method esEnemigo() = false
}
const imagenPerdedora = new Visuales(image = "pantallaPerder.png")
const imagenGanadora = new Visuales(image = "pantallaGanar.png")
class Visuales {
    var property image
    method position() = game.at(0,0)

    method mostrar(){ game.addVisual(self) }
    
}

object corazon inherits Visual
{
	var cerrado = true
	
	method image() = if(cerrado) "kokoro.png" else "kokoro2.png"
	method position() = game.at(8,10)
	override method puedePisarte(_) = true
	method abrir(){ tablero.sumarPuntaje(50) cerrado = false }
	method cerrar() { cerrado = true}
	
	method verificar(){
        if ((game.at(7,10).equals(juego.seleccionado().position()) or game.at(7,10).equals(juego.noSeleccionado().position())) and 
            ((game.at(9,10).equals(juego.seleccionado().position()) or game.at(9,10).equals(juego.noSeleccionado().position()))))
            {
            	game.removeTickEvent("verificarCorazon")
            	self.abrir()
				juego.pasarDeNivel()
            }
   		}
   }

class Pared inherits Visual
{
	const image = "assets/pared.png"
	
	method image() = image
}

class Bloque inherits Visual
{
	const image = "assets/bloque.png"
	
	method image() = image
}

class Telarana inherits Visual
{
	var position
	var nombre
	
	method nombre() = nombre
	method position() = position
	method image() = "assets/telarania.png"
	override method puedePisarte(_) = true
	override method esEnemigo() = true
	method eliminate() {
		tablero.sumarPuntaje(10)
		game.removeVisual(self)
		game.removeTickEvent(nombre)
		}
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