import wollok.game.*

object gestorDeSonido{
	var property sonando
	method sonidoJuego(){
		sonando = soundProducer.sound("assets/stageTheme.mp3")
		sonando.play()
		sonando.shouldLoop(true)
		sonando.volume(0.5)
	}
	method sonidoCursor(){
		sonando = soundProducer.sound("assets/Move.mp3")
		sonando.play()
		sonando.volume(0.5)
	}
	
	method sonidoActivarCorazon(){
		sonando = soundProducer.sound("assets/ganarNivel.mp3")
		sonando.play()
		sonando.volume(0.7)
	}
	
	method sonidoPerder(){
		sonando = soundProducer.sound("assets/perderNivel.mp3")
		sonando.play()
		sonando.volume(0.7)
	}
	
	method sonidoControles(){
		sonando = soundProducer.sound("assets/musicaControles.mp3")
		sonando.play()
		sonando.shouldLoop(true)
		sonando.volume(0.7)
	}
	method sonidoGanar(){
		sonando = soundProducer.sound("assets/ganarNivel.mp3")
		sonando.play()
		sonando.volume(0.7)
	}
	method pararMusica(){
		sonando.stop()
	}
}



object soundProducer {
	
	var provider = game
	
	method provider(_provider){
		provider = _provider
	}
	
	method sound(audioFile) = provider.sound(audioFile)
	
}
