class Pajaro {

    const ira
    var cantidadDeVecesEnojado = 0


    method fuerza()
    method enojarse() { cantidadDeVecesEnojado += 1 }
    

}

class PajaroComun inherits Pajaro {

    override method fuerza() = ira * 2

}

class Red inherits Pajaro {
    override method fuerza() = ira * 10 * cantidadDeVecesEnojado
}

class Bomb inherits Pajaro {

    var maximoDeFuerzaPermitido = 9000

    override method fuerza() = maximoDeFuerzaPermitido.min(ira * 2)
  
}

class Chuck inherits Pajaro {

    var velocidadAlCorrer = 10

    override method fuerza() = 150 + 0.max(velocidadAlCorrer - 80) * 5

    override method enojarse() { velocidadAlCorrer *= 2 }
  
}

class Terrence inherits Pajaro {

    var multiplicadorFuerza = 10

    override method fuerza() = ira * cantidadDeVecesEnojado * multiplicadorFuerza
  
}