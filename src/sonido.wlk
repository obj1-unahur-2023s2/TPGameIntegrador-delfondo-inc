import wollok.game.*

object gestorDeSonido{
	var activo = false
	var musica = game.sound("stageTheme.mp3")
	
	method iniciar(){
		musica.shouldLoop(true)
		activo = true
		musica.play()
	}

	method activar(){
		activo = true
		musica.resume()
	}
					
	method pausar(){
		activo = false
		musica.pause()
	}
	
	method alternar(otroSonido){
		const sonido = game.sound(otroSonido)
		sonido.play()
	}
	
	method ganar(){
		if (activo) musica.pause()
		musica = game.sound("ganar.mp3")
		musica.play()
	}
}