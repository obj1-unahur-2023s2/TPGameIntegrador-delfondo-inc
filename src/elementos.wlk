import wollok.game.*

object auto {
	var property position = game.at(0,0)
	var property image = "autitoRojo.png"
}

class Pared {
	const image = "paredLadrillos3.jpg"
	
	method image() = image
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
/* 
	method construirNivel(nivel){
 	nivel.forEach({
 		e=>e.addVisualIn(new Pared(), game.at(e.first(),e.last()))})}
 	}
*/
 