import wollok.game.*
import personajes.*
import juego.*

class Visual
{
	method imprimir(){ game.addVisual(self) } 
}

object corazon inherits Visual
{
	var cerrado = true
	
	method image() = if(cerrado) "kokoro.png" else "kokoro2.png"
	method position() = game.at(8,10)
	method puedePisarte(_) = true
	method esEnemigo() = false	
	method abrir(){ cerrado = false }
}

class Pared inherits Visual
{
	method image() = "assets/pared.png"
	method puedePisarte(_) = false
	method esEnemigo() = false
}

class Bloque inherits Visual
{
	var image = "assets/bloque.png"
	
	method image() = image
	method modo(num)
	{
		if(num == 2)
		{
			image = "assets/bloque2.png"
		} else
		if(num ==3)
		{
			image = "assets/bloque3.png"
		} else {
			image= "assets/bloque4.png"
		}
		
	}
	method puedePisarte(_) = false
	method esEnemigo() = false
}

class Telarana inherits Visual
{
	var position
	
	method image() = "assets/telarania.png"
	method puedePisarte(_) = true
	method esEnemigo() = true
	method eliminate() {
		game.removeVisual(self)}
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