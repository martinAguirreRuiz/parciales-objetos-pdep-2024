import src.Nave.*
object reducirElOxigeno {

    method serRealizadoContra(_unJugador) {
        nave.sabotearOxigeno(10)
    }
  
}

object impugnarJugador {
  
    method serRealizadoContra(unJugador) {
        unJugador.votarEnBlancoProximaReunion()
    }

}