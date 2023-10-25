import wollok.game.*
import movimientos.*
import juego.*

//Controles para los pinguinos
object controles {
	
	method asignarControles() {
		keyboard.w().onPressDo({juego.moverPinguinosEnY(arriba)})
		keyboard.d().onPressDo({juego.moverPinguinosEnX(derecha)})
		keyboard.s().onPressDo({juego.moverPinguinosEnY(abajo)})
		keyboard.a().onPressDo({juego.moverPinguinosEnX(izquierda)})
	}
}
	
