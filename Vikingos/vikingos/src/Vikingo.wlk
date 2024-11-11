class Vikingo {
  
    var castaSocial
    var oro

    method esProductivo() = castaSocial.puedeSubirAExpedicion(self) 
    method ganarOro(unaCantidad) { oro += unaCantidad }
    method efectosDeClaseMedia()

}

class Soldado inherits Vikingo {

    var asesinatos = 0
    const armas = []
    method tieneArmas() = !armas.isEmpty()

    override method esProductivo() = super() and self.matoMasDe(20) and self.tieneArmas()

    method matoMasDe(unaCantidad) = asesinatos > unaCantidad

    override method efectosDeClaseMedia() {
        10.times{ self.ganarArma() }
    }

    method ganarArma() {
        armas.add(new Arma())
    }

}

class Granjero inherits Vikingo {

    var cantidadDeHectareas
    var cantidadDeHijos

    override method esProductivo() = super() and cantidadDeHectareas >= 2 * cantidadDeHijos

    override method efectosDeClaseMedia() {
        cantidadDeHectareas += 2
        cantidadDeHijos += 2
    }

}

class Arma {
}