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
  
}