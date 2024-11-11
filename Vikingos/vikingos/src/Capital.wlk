class Capital {

    const factorDeRiqueza

    method valeLaPena(unaCantidadDeVikingos) = self.botinConseguido(unaCantidadDeVikingos) >= 3 * unaCantidadDeVikingos

    method botinConseguido(unaCantidadDeVikingos) = unaCantidadDeVikingos * factorDeRiqueza
}

class Aldea {

    // const iglesias = #{}
    var cantidadDeCrucifijos

    method valeLaPena() = self.botinConseguido() >= 15

    // method botinConseguido() = iglesias.sum { unaIglesia => unaIglesia.cantidadDeCrucifijos() }
    method botinConseguido() = cantidadDeCrucifijos
  
}

class AldeaAmurallada inherits Aldea {

    const comitiva = []

    override method valeLaPena() = super() and self.cantidadMinimaDeVikingos()

    method cantidadMinimaDeVikingos() = comitiva.size() > 10 // una cantidad mínima
  
}
