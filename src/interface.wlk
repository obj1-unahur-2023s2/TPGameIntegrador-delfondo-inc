import wollok.game.*
import elementos.*

object interface {
	method image(){}
	method position(){}
	
	method cargarNivel(numero){
		numero.iniciar()
	}
}

class Menu {
	method image(){}
	method position(){}
}

class Nivel {
	const posicionesNivel1 = [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8],[0,9],[0,10],[0,11],[1,11],[2,11]] // [X,Y]
	const posicionesNivel2 = [[0,0],[0,1],[0,2],[0,3]]
	
	method posicionesNivel1() = posicionesNivel1
	
	method posicionX(registro) = registro.first()
	method posicionY(registro) = registro.last()
	method agregarPared(ubicacion){
		game.addVisualIn(new Pared(), game.at(self.posicionX(ubicacion),self.posicionY(ubicacion)))
	}
	method construirNivel(nivel){
		nivel.forEach({ubicacion=>self.agregarPared(ubicacion)})
	}
}