import src.Nave.*
class Jugador {

    var nivelDeSospecha = 40
    const mochila = []
    const tareasARealizar = #{}

    method esSospechoso() = nivelDeSospecha > 50

    method buscarUnItem(unItem) {
      mochila.add(unItem)
    }

    method completoTodasSusTareas()

    method realizarUnaTareaPendiente()

    method aumentarNivelDeSospecha(unaCantidad) {
        nivelDeSospecha += unaCantidad
    }

    method reducirNivelDeSospecha(unaCantidad) {
        nivelDeSospecha -= unaCantidad
    }

    method tieneItem(unItem) = mochila.contains(unItem)

    method removerTarea(unaTarea) {
        tareasARealizar.remove(unaTarea)
    }
  
}

class Impostor inherits Jugador {

    override method completoTodasSusTareas() = true

    override method realizarUnaTareaPendiente() { /* No hace nada */ }
  
}

class Tripulante inherits Jugador {

    override method completoTodasSusTareas() = tareasARealizar.isEmpty()

    override method realizarUnaTareaPendiente() { 
        const tareaPendiente = tareasARealizar.anyOne()
        tareaPendiente.serRealizada(self)
        self.removerTarea(tareaPendiente)
        nave.serInformada()
    }

}