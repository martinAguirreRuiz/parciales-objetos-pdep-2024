import src.Item.*
import src.Nave.*
class Tarea {

    method serRealizada(unJugador) { 
        self.chequearRestricciones(unJugador)
        self.aplicarEfectosTarea(unJugador)
    }

    method chequearRestricciones(unJugador)
    method aplicarEfectosTarea(unJugador)
  
}
object arreglarTableroElectrico inherits Tarea {

    override method chequearRestricciones(unJugador) { if(!unJugador.tieneItem(llaveInglesa)) throw new DomainException(message = "El tripulante no cumple las restricciones") }

    override method aplicarEfectosTarea(unJugador) {
      unJugador.aumentarNivelDeSospecha(10)
    }
}

object sacarLaBasura inherits Tarea {

    override method chequearRestricciones(unJugador) { if(!unJugador.tieneItem(escoba) or !unJugador.tieneItem(bolsaDeConsorcio)) throw new DomainException(message = "El tripulante no cumple las restricciones") }

    override method aplicarEfectosTarea(unJugador) {
      unJugador.reducirNivelDeSospecha(4)
    }
}

object ventilarLaNave inherits Tarea {

    override method chequearRestricciones(_unJugador) { /* No tiene restricciones */ }

    override method aplicarEfectosTarea(_unJugador) { nave.serVentilada() }
  
}