import wollok.game.*
import interface.*
import elementos.*

object tablero
{
	const puntaje = new Puntaje()
	const tiempo = new Tiempo()
	const nivel = new NivelTabla()
	
	method nivelDato(nuevo){ nivel.inicializar(nuevo) }
	method sumarPuntaje(numero){ puntaje.sumar(numero) }
	method reiniciarScore(){puntaje.reiniciar()}
	method iniciar()
	{
		puntaje.imprimir()
		tiempo.imprimir()
		tiempo.contador()
		nivel.imprimir()
	}
	method sumarTiempoRestante(){
		tiempo.clear()
		puntaje.sumar(tiempo.tiempo().get(0).num()*3)
		puntaje.sumar(tiempo.tiempo().get(1).num()*2)
		puntaje.sumar(tiempo.tiempo().get(2).num()*1)
	}
	method estaEnCero() = tiempo.cero()
	method imprimirTodo(){puntaje.imprimir() tiempo.imprimir() nivel.imprimir()}
}

class Puntaje inherits Visual
{
	const mostrar = [ new Digito(posicion = game.at(3,12)), new Digito(posicion = game.at(4,12)), new Digito(posicion = game.at(5,12)) ]
	
	var puntaje = 0
	const image = "puntaje.png"
	
	method position(){ return game.at(0,12) }
	method image(){ return image }
	method reiniciar(){
		mostrar.forEach({p=>p.inicial(0)})
		puntaje=0
	}
	
	override method imprimir()
	{
		super()
		mostrar.forEach({ n => n.imprimir() })
	}
	method sumar(puntos)
	{
		puntaje += puntos
		if(puntaje < 9)
		{
			mostrar.last().inicial(puntaje)
		} else 
		if(puntaje < 99)
		{
			mostrar.last().inicial(puntaje % 10)
			mostrar.get(1).inicial(puntaje.div(10))
		} 
		else 
		if(puntaje < 1000)
		{
			mostrar.last().inicial(puntaje % 10)
			mostrar.get(1).inicial((puntaje % 100).div(10))
			mostrar.first().inicial(puntaje.div(100))
		} else {
			puntaje = 999
		}
	}
}


class Tiempo inherits Visual
{
	const tiempo = [ new Digito(posicion = game.at(9,12)), new Digito(posicion = game.at(10,12)), new Digito(posicion = game.at(11,12)) ]
	method image(){ return "tiempo.png" }
	method position(){ return game.at(6,12) }
	method cero(){ return tiempo.all({ d => d.num() == 0 }) }
	method clear(){ game.removeTickEvent("unidad") }
	method tiempo()=tiempo
	override method imprimir()
	{ 
		super()
		tiempo.forEach({ n => n.imprimir() })
	}
	method inicializar()
	{
		tiempo.first().inicial(9)
		tiempo.get(1).inicial(0)
		tiempo.last().inicial(0)
	}
	method contador()
	{ 
		self.inicializar()

		game.onTick(100,"unidad",{ 
			tiempo.last().restar()
			if(tiempo.last().num() == 9) { tiempo.get(1).restar() }
			if(tiempo.last().num() == 9 and tiempo.get(1).num() == 9) { tiempo.first().restar() }
			if(self.cero()) self.clear()
		} )
	}
}

class NivelTabla inherits Visual
{
	var image = "ph.png" 
	
	method position(){ return game.at(12,12) }
	method image(){ return image }
	method inicializar(nueva){ image = nueva + ".png" }
}

class Digito inherits Visual
{
	var posicion
	var image = "0.png"
	var num = 0
	
	method image(){ return num.toString() + ".png" }
	method position(){ return posicion }
	method num(){ return num }
	
	method digString(){ return num.toString() }
	method inicial(_num){ num = _num }
	method restar(){ if( num > 0 ) { num -= 1 } else { num = 9 } }
}