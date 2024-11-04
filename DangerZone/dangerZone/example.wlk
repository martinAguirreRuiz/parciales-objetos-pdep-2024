// class Empleado {

//   var salud
//   const habilidades
//   const jefe = null

//   method estaIncapacitado() = salud < self.saludCritica()
  
//   method saludCritica()

//   method puedeUsarHabilidad(unaHabilidad) = !self.estaIncapacitado() and self.poseeHabilidad(unaHabilidad)

//   method poseeHabilidad(unaHabilidad) = if(jefe == null) habilidades.contains(unaHabilidad) else jefe.poseeHabilidad(unaHabilidad)

//   method cumplirMision(unaMision) {
//     self.puedeUsarHabilidadesDeMision(unaMision)
//     self.sufrirDanio(unaMision)
//     self.registrarMision(unaMision)
//   }

//   method puedeUsarHabilidadesDeMision(unaMision) {
//     if(!unaMision.puedeUsarHabilidadesRequeridas(self)){
//       throw new DomainException(message="No se poseen todas las habilidades necesarias para completar la misión")
//     }
//   }

//   method sufrirDanio(unaMision) {
//     unaMision.generarDanio(self)
//   }

//   method reducirSalud(unaSalud) {
//     salud -= unaSalud
//   }

//   method registrarMision(unaMision)

//   method noPoseeHabilidad(unaHabilidad) = ! habilidades.contains(unaHabilidad)

//   method agregarHabilidad(unaHabilidad) {
//     habilidades.add(unaHabilidad)
//   }


// }

// class Espia inherits Empleado {

//   override method saludCritica() = 15

//   override method registrarMision(unaMision) {
//     self.aprenderHabilidadesMision(unaMision)
//   }

//   method aprenderHabilidadesMision(unaMision) {
//     unaMision.darHabilidades(self)
//   }

// }

// class Oficinista inherits Empleado {

//   var estrellas

//   override method saludCritica() = 40 - 5 * estrellas

//   override method registrarMision(unaMision) {
//     self.ganarEstrella()
//     // self.convertirAEspia()
//   }
  
//   method ganarEstrella() {
//     estrellas += 1
//   }

//   // method convertirAEspia() = 

// }

// class Jefe {

//   const subordinados

//   method poseeHabilidad(unaHabilidad) = subordinados.any { unSubordinado => unSubordinado.poseeHabilidad(unaHabilidad) }
  
// }

// class Mision {

//   const habilidadesRequeridas 
//   const peligrosidad

//   method puedeUsarHabilidadesRequeridas(unEmpleado) = habilidadesRequeridas.all { unaHabilidad => unEmpleado.puedeUsarHabilidad(unaHabilidad) }
  
//   method generarDanio(unEmpleado) {

//     unEmpleado.reducirSalud(peligrosidad)
    
//   }

//   method darHabilidades(unEmpleado) {
//     habilidadesRequeridas.forEach { unaHabilidad => if(unEmpleado.noPoseeHabilidad(unaHabilidad)) unEmpleado.agregarHabilidad(unaHabilidad) }
//   }

// }

// **************************** VERSIÓN 2 ****************************

class Empleado {

  var salud = 100
  var puesto
  const habilidades

  method estaIncapacitado() = salud < self.saludCritica()

  method saludCritica() = puesto.saludCritica()

  method puedeUsarHabilidad(unaHabilidad) = ! self.estaIncapacitado() and self.poseeHabilidad(unaHabilidad)

  method poseeHabilidad(unaHabilidad) = habilidades.contains(unaHabilidad)

  method cumplirMision(unaMision) {
    self.puedeUsarHabilidadesRequeridas(unaMision)
    self.sufrirConsecuencias(unaMision)
    self.registrarMision(unaMision)
  }

  method puedeUsarHabilidadesRequeridas(unaMision) {
    if(!unaMision.puedeUsarHabilidadesRequeridas(self)){
      throw new DomainException(message = "El empleado no puede realizar la misión, no cumple con todas las habilidades requeridas")
    }
  }

  method sufrirConsecuencias(unaMision) {
    unaMision.daniarEmpleado(self)
  }

  method registrarMision(unaMision) {
    puesto.registrarMision(unaMision, self)
  }

  method noPoseeHabilidad(unaHabilidad) = !habilidades.contains(unaHabilidad)

  method aprenderHabilidad(unaHabilidad) {
    habilidades.add(unaHabilidad)
  }

  method cambiarDePuesto(unNuevoPuesto) {
    puesto = unNuevoPuesto
  }

}

class Jefe inherits Empleado {

  const subordinados

  override method poseeHabilidad(unaHabilidad) = super(unaHabilidad) or self.algunSubordinadoPoseeHabilidad(unaHabilidad)

  method algunSubordinadoPoseeHabilidad(unaHabilidad) = subordinados.any { unSubordinado => unSubordinado.puedeUsarHabilidad(unaHabilidad) }
  
}
object espia {
  method saludCritica() = 15
  method registrarMision(unaMision, unEmpleado) {
    unaMision.aprenderHabilidadesFaltantes(unEmpleado)
  }
}

class Oficinista {
  var estrellas
  method saludCritica() = 40 - 5 * estrellas
  method registrarMision(_unaMision, unEmpleado) {
    self.ganarEstrella()
    self.chequearCambioDePuesto(unEmpleado)
  }

  method ganarEstrella() {
    estrellas += 1
  }

  method chequearCambioDePuesto(unEmpleado) {
    if(estrellas > 3){
      unEmpleado.cambiarDePuesto(espia)
    }
  }

}

class Mision {

  const habilidadesRequeridas
  const peligrosidad

  method puedeUsarHabilidadesRequeridas(unEmpleado) = habilidadesRequeridas.all { unaHabilidad => unEmpleado.puedeUsarHabilidad(unaHabilidad) }
  
  method daniarEmpleado(unEmpleado) {
    unEmpleado.quitarVida(peligrosidad)
  }

  method aprenderHabilidadesFaltantes(unEmpleado) {
    habilidadesRequeridas.forEach { unaHabilidad => if(unEmpleado.noPoseeHabilidad(unaHabilidad)) unEmpleado.aprenderHabilidad(unaHabilidad) }
  }

}



