class Expedicion {

  const vikingosSubidos = #{}

  method subirUnVikingo(unVikingo) { 
    self.puedeSubir(unVikingo)
    vikingosSubidos.add(unVikingo)
  }

  method puedeSubir(unVikingo) { if(!unVikingo.esProductivo()) throw new DomainException(message = "El vikingo no puede subir a la expedición")}


}