import wollok.game.*
import movimientos.*
import juego.*

//Controles para los pinguinos
object controles {
	
	method controlesPinguinos() {
		keyboard.w().onPressDo({juego.moverPinguinosEnY(arriba)})
		
		keyboard.d().onPressDo({juego.moverPinguinosEnX(derecha)})
		
		keyboard.s().onPressDo({juego.moverPinguinosEnY(abajo)})
		
		keyboard.a().onPressDo({juego.moverPinguinosEnX(izquierda)})
		
		keyboard.space().onPressDo({juego.realizarAtaques()})
		
		keyboard.q().onPressDo({juego.girarPinguinos()})
		
	}
}
	
