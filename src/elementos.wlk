import wollok.game.*

object auto {
	var property position = game.at(0,0)
	var property image = "autitoRojo.png"
}

object corazon
{
	var cerrado = true
	
	method image() = if(cerrado) "" else ""
	method abrir(){ cerrado = false }
}

class Pared {
	method image() = "ladrilloPrueba.png"
}

class Personaje{
	var position = game.at(x,y)
	var x
	var y
	
	method position() = position
	
	method pasoArriba(){
		position = position.up(1)
	}
	
	method pasoDerecha(){
		position = position.right(1)
	}
	
	method pasoAbajo(){
		position = position.down(1)
	}
	
	method pasoIzquierda(){
		position = position.left(1)
	}
}

class Telarana {
	
}
 