class Vikingo {
  
    var castaSocial
    const armas = []
    var oro

    method esProductivo() = castaSocial.puedeSubirAExpedicion(self) 
    method tieneArmas() = !armas.isEmpty()
    method ganarOro(unaCantidad) { oro += unaCantidad }

}

class Soldado inherits Vikingo {

    var asesinatos = 0

    override method esProductivo() = super() and self.matoMasDe(20) and self.tieneArmas()

    method matoMasDe(unaCantidad) = asesinatos > unaCantidad

}

class Granjero inherits Vikingo {

    var cantidadDeHectareas
    var cantidadDeHijos

    override method esProductivo() = super() and cantidadDeHectareas >= 2 * cantidadDeHijos

}