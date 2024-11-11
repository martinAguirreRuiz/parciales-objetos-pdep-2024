class Jugador {

    var nivelDeSospecha = 40
    const mochila = []
    const tareasARealizar = #{}

    method esSospechoso() = nivelDeSospecha > 50

    method buscarUnItem(unItem) {
      mochila.add(unItem)
    }

    method completoTodasSusTareas()
  
}

class Impostor inherits Jugador {

    override method completoTodasSusTareas() = true
  
}

class Tripulante inherits Jugador {

    override method completoTodasSusTareas() = tareasARealizar.isEmpty()
  
}