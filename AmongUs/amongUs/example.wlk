// ******************************** 
// ************* NAVE *************
// ******************************** 

object nave {

  var nivelDeOxigeno = 0
  const todosLosJugadores = []
  const jugadoresVivos = []

  method chequearTareas() {
    if(self.todosCompletaronSusTareas()){
      throw new DomainException(message = "Victoria de los Tripulantes, completaron todas sus tareas")
    }
  }

  method todosCompletaronSusTareas() = todosLosJugadores.all { unJugador => unJugador.completoTodasSusTareas() }

  method aumentarNivelDeOxigeno(unNivelDeOxigeno) {
    nivelDeOxigeno += unNivelDeOxigeno
  }

  method reducirNivelDeOxigeno(unNivelDeOxigeno) {
    if(self.nadieTieneTuboDeOxigeno()){
      nivelDeOxigeno -= unNivelDeOxigeno
      self.revisarNivelDeOxigeno()
    }
  }

  method nadieTieneTuboDeOxigeno() = not todosLosJugadores.any { unJugador => unJugador.posee(tuboDeOxigeno)}

  method revisarNivelDeOxigeno() {
    if(nivelDeOxigeno <= 0){
      throw new DomainException(message = "Victoria de los Impostores, la nave se quedó sin oxígeno")
    }
  }


  method comenzarVotacion() {
    self.votanJugadoresVivos()
    self.expulsarAlMasVotado()
    self.resetearVotosImpugnados()
  }

  method votanJugadoresVivos() {

    var listaDeVotos = jugadoresVivos.map { unJugador => unJugador.votar() }
    var jugadorMasVotado = listaDeVotos.max { unJugador => listaDeVotos.ocurrencesOf(unJugador)}
    self.expulsarDeLaNave(jugadorMasVotado)

  }

  method jugadorAlAzar() = jugadoresVivos.anyOne()

  method jugadorNoSospechoso() = jugadoresVivos.findOrDefault ({ unJugador => ! unJugador.esSospechoso()}, votoEnBlanco)

  method jugadorConMayorNivelDeSospecha() = jugadoresVivos.max { unJugador => unJugador.nivelDeSospecha() }

  method jugadorConLaMochilaVacia() = jugadoresVivos.findOrDefault({ unJugador => unJugador.noTieneItems() }, votoEnBlanco)

  method resetearVotosImpugnados() {

    jugadoresVivos.forEach { unJugador => unJugador.resetearVotoImpugnado() }
    
  }


}

// ******************************** 
// *********** JUGADORES **********
// ******************************** 

class Jugador {

  var nivelDeSospecha
  const mochila = []
  const tareasARealizar = []
  var votoImpugnado = false

  method nivelDeSospecha() = nivelDeSospecha

  method esSospechoso() = nivelDeSospecha > 50
  method buscarItem(unItem) {
    mochila.add(unItem)
  }
  method posee(unItem) = mochila.contains(unItem)
  method aumentarNivelDeSospecha(unNivelDeSospecha) {
    nivelDeSospecha += unNivelDeSospecha
  }
  method reducirNivelDeSospecha(unNivelDeSospecha) {
    nivelDeSospecha -= unNivelDeSospecha
  }
  method noTieneItems() = mochila.isEmpty()

  method completoTodasSusTareas()
  method realizarTarea()
  method impugnarVotoProximaRonda() {
    votoImpugnado = true
  }
  method llamarReunionDeEmergencia() {
    nave.comenzarVotacion()
  }

  method votar()

 method resetearVotoImpugnado() {
    votoImpugnado = false
 }

}

class Tripulante inherits Jugador {

  const personalidad

  override method completoTodasSusTareas() = tareasARealizar.isEmpty()
  override method realizarTarea() {
    const tareaDisponible = tareasARealizar.anyOne()
    tareaDisponible.realizarse(self)
    tareasARealizar.remove(tareaDisponible)
  }

  method quitarItem(unItem) = mochila.remove(unItem)
  
  override method votar() = 
    if(!votoImpugnado){
      personalidad.votar()
    }else{
      self.votarEnBlanco()
    }

}

class Impostor inherits Jugador {
  override method completoTodasSusTareas() = true
  override method realizarTarea(){}
  method realizarSabotaje(unSabotaje, unTripulante) {
    unSabotaje.afectar(unTripulante)
    self.aumentarNivelDeSospecha(5)
  }

  override method votar() = nave.jugadorAlAzar()
}

// ******************************** 
// ************ TAREAS ************
// ******************************** 

class Tarea {

  method realizarse(unTripulante) {
    if(self.requisito(unTripulante)){
      self.afectar(unTripulante)
    }
  }

  method requisito(_unTripulante)
  method afectar(_unTripulante)
  method informarALaNave() {
    nave.chequearTareas()
  }
}

object arreglarTablero inherits Tarea {

  override method requisito(unTripulante) = unTripulante.posee(llaveInglesa)
  override method afectar(unTripulante) {
    unTripulante.aumentarNivelDeSospecha(10)
    unTripulante.quitarItem(llaveInglesa)
    self.informarALaNave()
  }
}

object sacarLaBasura inherits Tarea {

  override method requisito(unTripulante) = unTripulante.posee(escoba) and unTripulante.posee(bolsaDeConsorcio)
  override method afectar(unTripulante) {
    unTripulante.reducirNivelDeSospecha(4)
    unTripulante.quitarItem(escoba)
    unTripulante.quitarItem(bolsaDeConsorcio)
    self.informarALaNave()
  }
}

object ventilarLaNave inherits Tarea {
  override method requisito(_unTripulante) = true
  override method afectar(_unTripulante) {
    nave.aumentarNivelDeOxigeno(5)
    self.informarALaNave()
  }
  
}

// ******************************** 
// ************ ITEMS *************
// ******************************** 

object llaveInglesa {
}
object escoba {
}
object bolsaDeConsorcio {
}
object tuboDeOxigeno {
}

// ******************************** 
// ********** SABOTAJES ***********
// ******************************** 


object reducirOxigeno {
  method afectar(_unTripulante) {
    nave.reducirNivelDeOxigeno(10)
  }
}

object impugnarAUnJugador {
  method afectar(unTripulante) {
    unTripulante.impugnarVotoProximaRonda()
  }
}


// ******************************** 
// ********* PERSONALIDAD *********
// ********************************

object troll {
  method votar() = nave.jugadorNoSospechoso()
}

object detective {
  method votar() = nave.jugadorConMayorNivelDeSospecha()
}

object materialista {
  method votar() = nave.jugadorConLaMochilaVacia()
}


