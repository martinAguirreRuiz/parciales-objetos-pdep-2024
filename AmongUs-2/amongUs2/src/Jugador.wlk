import Item.*
import src.Nave.*
class Jugador {

    var nivelDeSospecha = 40
    const mochila = []
    const tareasARealizar = #{}
    var votaEnBlanco = 0
    var votosEnContra = 0

    method nivelDeSospecha() = nivelDeSospecha

    method votosEnContra() = votosEnContra

    method esSospechoso() = nivelDeSospecha > 50

    method buscarUnItem(unItem) { mochila.add(unItem) }

    method noTieneCosas() = mochila.isEmpty()

    method completoTodasSusTareas()

    method realizarUnaTareaPendiente()

    method aumentarNivelDeSospecha(unaCantidad) { nivelDeSospecha += unaCantidad } 

    method reducirNivelDeSospecha(unaCantidad) { nivelDeSospecha -= unaCantidad }

    method tieneItem(unItem) = mochila.contains(unItem)

    method removerTarea(unaTarea) { tareasARealizar.remove(unaTarea) }

    method llamarReunionDeEmergencia() { nave.comenzarVotacion() }

    method votarEnBlancoProximaReunion() { votaEnBlanco = 1 }

    method puedeVotar() { 
        votaEnBlanco = 0
        votosEnContra = 0 
    }

    method sumarVotoEnContra() { votosEnContra += 1 }

    method votar()
  
}

class Impostor inherits Jugador {

    override method completoTodasSusTareas() = true

    override method realizarUnaTareaPendiente() { /* No hace nada */ }

    method realizarSabotaje(unSabotaje, unJugador) { unSabotaje.serRealizadoContra(unJugador) }

    override method votar() = nave.cualquierJugadorVivo()
  
}

class Tripulante inherits Jugador {

    const personalidad

    override method completoTodasSusTareas() = tareasARealizar.isEmpty()

    override method realizarUnaTareaPendiente() { 
        const tareaPendiente = tareasARealizar.anyOne()
        tareaPendiente.serRealizada(self)
        self.removerTarea(tareaPendiente)
        nave.serInformada()
    }

    override method votar() = if(votaEnBlanco == 1) votoEnBlanco else personalidad.votar()

}