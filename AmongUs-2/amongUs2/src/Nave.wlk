import Sabotaje.*
import src.Item.*
object nave {

    var nivelDeOxigeno = 100
    const jugadores = #{}
    const impostoresVivos = #{}
    const tripulantesVivos = #{}

    method serVentilada() {
        nivelDeOxigeno += 5
    }

    method serInformada() { if(self.todasLasTareasCompletadas()) throw new DomainException(message = "Ganaron los Tripulantes")}

    method todasLasTareasCompletadas() = jugadores.all { unJugador => unJugador.completoTodasSusTareas() }

    method sabotearOxigeno(unaCantidad) { 
        self.reducirOxigeno(unaCantidad)
        self.chequearOxigeno()
    }

    method reducirOxigeno(unaCantidad) {
        if(self.nadieTiene(tuboDeOxigeno)) nivelDeOxigeno = 0.max(nivelDeOxigeno - unaCantidad)
    }

    method nadieTiene(unItem) = ! tripulantesVivos.any { unTripulante => unTripulante.tieneItem(unItem) }  

    method chequearOxigeno() { if(nivelDeOxigeno == 0) throw new DomainException(message = "Ganarion los Impostores") }
  
}