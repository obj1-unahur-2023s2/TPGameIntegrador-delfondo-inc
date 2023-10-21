import wollok.game.*

object gestorDeSonido{
	var activo = false
	const musica = game.sound("stageTheme.mp3")
	
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
}