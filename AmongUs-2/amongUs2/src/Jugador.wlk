class Jugador {

    var nivelDeSospecha = 40
    const mochila = []

    method esSospechoso() = nivelDeSospecha > 50

    method buscarUnItem(unItem) {
      mochila.add(unItem)
    }
  
}