import Sabotaje.*
import src.Item.*
object nave {

    var nivelDeOxigeno = 100
    const jugadores = []
    const impostoresVivos = []
    const tripulantesVivos = []
    const jugadoresVivos = []

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

    method comenzarVotacion() {

        const listaDeVotos = self.obtenerListaDeVotos()
        
        self.contarVotos(listaDeVotos)

        const jugadorConMasVotos = self.jugadorConMasVotos()
        const cantidadDeVotosEnBlanco = listaDeVotos.occurrencesOf(votoEnBlanco)
        const cantidadDeVotosJugador = listaDeVotos.occurrencesOf(jugadorConMasVotos)
        
        self.expulsarJugador(jugadorConMasVotos, cantidadDeVotosEnBlanco, cantidadDeVotosJugador)
        self.chequearVictoria()
        self.desempugnarJugadores()

        
    }

    method obtenerListaDeVotos() = jugadoresVivos.map { unJugador => unJugador.votar() }

    method contarVotos(listaDeVotos) { listaDeVotos.forEach { unJugador => unJugador.sumarVotoEnContra() } }

    method jugadorConMasVotos() = jugadoresVivos.max { unJugador => unJugador.votosEnContra() }

    method expulsarJugador(unJugador, cantidadDeVotosEnBlanco, cantidadDeVotosJugador) {
        if(cantidadDeVotosJugador >= cantidadDeVotosEnBlanco) {
            jugadoresVivos.remove(unJugador)
            tripulantesVivos.remove(unJugador)
            impostoresVivos.remove(unJugador)
        }
    } 

    method chequearVictoria() {
        if(impostoresVivos.isEmpty()) {
            throw new DomainException(message = "Ganaron los Tripulantes")
        }else if(impostoresVivos.size() == tripulantesVivos.size()){
            throw new DomainException(message = "Ganaron los Impostores")
        }
    }

    method desempugnarJugadores() { jugadoresVivos.forEach { unJugador => unJugador.puedeVotar() }}

    method cualquierJugadorVivo() = jugadoresVivos.anyOne()

    method cualquierJugadorNoSospechoso() = jugadoresVivos.findOrDefault ({ unJugador => !unJugador.esSospechoso() }, {votoEnBlanco})

    method jugadorConMayorSospecha() = jugadoresVivos.max { unJugador => unJugador.nivelDeSospecha() }

    method cualquierJugadorSinCosas() = jugadoresVivos.findOrDefault ({ unJugador => unJugador.noTieneCosas() }, {votoEnBlanco})

}