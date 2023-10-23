import wollok.game.*

object auto {
	var property position = game.at(0,0)
	var property image = "autitoRojo.png"
}

object corazon {
	var cerrado = true
	
	method image() = if(cerrado) "" else ""
	method abrir(){ cerrado = false }
}

class Pared {
	method image() = "ladrilloPrueba.png"
}

class Telarana {}
 
