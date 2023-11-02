import wollok.game.*
import elementos.*

object interface {
	method image(){}
	method position(){}
	
	method nivel1(){
		const nivel = [ [1,4],[1,8],[2,2],[2,4],[2,6],[2,8],[2,9],[3,2],[3,6],[3,9],
				[4,2],[4,4],[4,6],[4,8],[4,9],[5,2],[5,6],[6,2],[6,4],[6,6],[6,8],[6,9],
				[7,2],[7,9],[9,2],[9,8],[10,2],[10,4],[10,6],[10,8],[10,9],[11,2],[11,6],[11,9],
				[12,2],[12,4],[12,6],[12,8],[12,9],[13,2],[13,6],[14,2],
				[14,4],[14,6],[14,8],[14,9],[15,4],[15,9]
				]
		
		(1..9).forEach({ i => nivel.add([8,i]) })
		
		return nivel
	}
}

class Menu {
	method image(){}
	method position(){}
}

class Nivel {
	
	
	method posicionX(registro) = registro.first()
	method posicionY(registro) = registro.last()
	
	
	method construirNivel(lista){
		lista.forEach({ p => self.agregarBloque(p) })
		self.marco().forEach({ e => self.agregarPared(e) })
	}
	
	method agregarBloque(ubicacion){
		game.addVisualIn(new Bloque(), game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}
	
	method agregarPared(ubicacion){
		game.addVisualIn(new Pared(), game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}
	
	method marco(){
		const marco = []
		
		(0..16).forEach({ i => marco.add([i,0]) })
		(1..11).forEach({ i => marco.add([0,i]) })
		(1..16).forEach({ i => marco.add([i,11]) })
		(1..10).forEach({ i => marco.add([16,i]) })
		
		return marco
	}
	
}