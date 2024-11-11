class Expedicion {

  const vikingosSubidos = #{}
  const aldeasInvolucradas = #{}
  const capitalesInvolucradas = #{}


  method subirUnVikingo(unVikingo) { 
    self.puedeSubir(unVikingo)
    vikingosSubidos.add(unVikingo)
  }

  method puedeSubir(unVikingo) { if(!unVikingo.esProductivo()) throw new DomainException(message = "El vikingo no puede subir a la expedición")}

  method valeLaPena() = self.aldeasYCapitalesValenLaPena()

  method aldeasYCapitalesValenLaPena() = 
    aldeasInvolucradas.all { unaAldea => unaAldea.valeLaPena() } and 
    capitalesInvolucradas.all { unaCapital => unaCapital.valeLaPena(vikingosSubidos.size()) 
  }

  method realizarUnaExpedicion() {

    const botinConseguido = 
      aldeasInvolucradas.sum { unaAldea => unaAldea.botinConseguido(vikingosSubidos.size())} + 
      capitalesInvolucradas.sum { unaCapital => unaCapital.botinConseguido()}

    const botinPorVikingo = botinConseguido / vikingosSubidos.size()

    vikingosSubidos.forEach { unVikingo => unVikingo.ganarOro(botinPorVikingo) }

  }

}