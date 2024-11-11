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

  

}