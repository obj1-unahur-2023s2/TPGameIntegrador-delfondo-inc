import wollok.game.*
import elementos.*
import juego.*

object gestorNiveles{
	var property nivelActualNumero = 1
	var property nivelActual = nivel1
	
	method ultimoNivel() = self.nivelActual().siguienteNivel() == null
	
	method cargarSiguienteNivel(){
		if(!self.ultimoNivel()){
			nivelActual = nivelActual.siguienteNivel()
			nivelActualNumero++
			nivelActual.iniciar()	
		}
		else{
			juego.ganar()
		}
	}
}

class Nivel {
	var property siguienteNivel = null
	var property paredes = []
	var property corazonGanador = null
	var property telaranias = []
	var property aranias = []
	
	method posicionX(registro) = registro.first()
	method posicionY(registro) = registro.last()
	method agregarPared(ubicacion){
		game.addVisualIn(new Pared(), game.at(self.posicionX(ubicacion),self.posicionY(ubicacion)))
	}
	method agregarBloque(ubicacion){
		game.addVisualIn(new Bloque(), game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}
	method agregarCorazon(ubicacion){
		game.addVisualIn(corazon, game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}
	method agregarTelarania(ubicacion){
		game.addVisualIn(new Telarana(), game.at(self.posicionX(ubicacion), self.posicionY(ubicacion)) )
	}

	method construirNivel(){
		game.clear()
		const marco = []
		
		(0..16).forEach({ i => marco.add([i,0]) })
		(1..11).forEach({ i => marco.add([0,i]) })
		(1..16).forEach({ i => marco.add([i,11]) })
		(1..10).forEach({ i => marco.add([16,i]) })
		paredes.forEach({ubicacion=>self.agregarPared(ubicacion)})
		marco.forEach({ubicacion=>self.agregarBloque(ubicacion)})
		telaranias.forEach({ubicacion=>self.agregarTelarania(ubicacion)})
		self.agregarCorazon(corazonGanador)
	}
	
	method iniciar() {
		self.construirNivel()
		juego.cargarPersonajes()
		juego.agregarEnemigos()
		juego.cargarControles()
	}
}

const nivel1 = new Nivel(
	siguienteNivel = nivel2,
	paredes = [ [1,4],[1,8],[2,2],[2,4],[2,6],[2,8],[2,9],[3,2],[3,6],[3,9],
				[4,2],[4,4],[4,6],[4,8],[4,9],[5,2],[5,6],[6,2],[6,4],[6,6],
				[6,8],[6,9],[7,2],[7,9],[8,1],[8,2],[8,3],[8,4],[8,5],[8,6],
				[8,7],[8,8],[8,9],[9,2],[9,8],[10,2],[10,4],[10,6],[10,8],[10,9],
				[11,2],[11,6],[11,9],[12,2],[12,4],[12,6],[12,8],[12,9],[13,2],[13,6],
				[14,2],[14,4],[14,6],[14,8],[14,9],[15,4],[15,9]],
	corazonGanador = [8,10],
	telaranias = null,
	aranias = [6,7]
)

const nivel2 = new Nivel(
	siguienteNivel = nivel3,
	paredes = [[2,5],[3,3],[3,5],[3,7],[3,9],[3,10],[4,7],[5,3],[5,4],[5,5],[5,7],[5,8],[5,9],[5,10],[6,5],[7,2],[7,3],[7,5],[7,7],[7,9],[7,10],[8,7],[9,2],[9,3],[9,4],[9,5],[9,6],[9,7],[9,8],[9,9],[9,10],[10,3],[10,7],[10,10],[11,3],[11,5],[11,7],[11,9],[11,10],[12,5],[12,9],[13,3],[13,5],[13,7],[13,8],[13,9],[13,10],[14,5],[14,9],[15,3],[15,5],[15,7],[15,9],[15,10],[16,3],[16,7]],
	corazonGanador = [8,10],
	telaranias = null,
	aranias = null
)

const nivel3 = new Nivel(
	siguienteNivel = null,
	paredes = null,
	corazonGanador = [8,10],
	telaranias = null,
	aranias = null
)