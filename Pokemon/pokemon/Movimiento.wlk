class Movimiento {
  
  var usos

  method poder()

  method serUtilizado(unUtilizador, unContrincante) {
    self.estaDisponible()
    self.aplicarEfecto(unUtilizador, unContrincante)
    self.decrementarUso(1)
  }

  method estaDisponible() { if(usos <= 0) throw new DomainException(message = "Movimiento agotado") else true  }

  method aplicarEfecto(unUtilizador, unContrincante)

  method decrementarUso(unaCantidad) { usos -= unaCantidad }

}

class MovimientoCurativo inherits Movimiento {
  
    const cantidadDeVidaCurada

    override method poder() = cantidadDeVidaCurada

    override method aplicarEfecto(unUtilizador, _unContrincante) {
        unUtilizador.recuperarVida(cantidadDeVidaCurada)
    }

}

class MovimientoDanino inherits Movimiento {

    const danioQueProduce

    override method poder() = self.danioQueProduce() * 2

    method danioQueProduce() = danioQueProduce
    
    override method aplicarEfecto(_unUtilizador, unContrincante) {
        unContrincante.recibirDanio(danioQueProduce)
    }

}

class MovimientoEspecial inherits Movimiento {

    const condicion

    override method poder() = condicion.poder()

    override method aplicarEfecto(_unUtilizador, unContrincante) {
        unContrincante.condicion(condicion)
    }
  
}