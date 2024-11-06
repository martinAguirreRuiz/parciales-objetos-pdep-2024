// FILOSOFOS
class Filosofo {

  const nombre
  const honorificos = #{}
  const actividades
  var nivelDeIluminacion
  var diasVividosEsteAnio
  var edad
  const argumentos

  method presentarse() = self.honorificosFormateados() + " " + nombre
  
  method honorificosFormateados() = self.titulosDeHonorificos().join(",")

  method titulosDeHonorificos() = honorificos.map { unHonorifico => unHonorifico.titulo() }

  method estaEnLoCorrecto() = nivelDeIluminacion > 1000

  method vivirUnDia() {
    self.realizarActividades()
    self.envejecer()
  }

  method envejecer() {
    diasVividosEsteAnio += 1
    self.cumplirAnios()
  }

  method cumplirAnios() {
    if(self.cumpleAnios()){
      self.aumentarNivelDeIluminacion(10)
      edad += 1
      diasVividosEsteAnio = 0
      if(self.cumpleSesentaAnios()) self.agregarHonorifico(elSabio)
    }
  }

  method cumpleAnios() = diasVividosEsteAnio == 365

  method cumpleSesentaAnios() = edad == 60

  method realizarActividades() {
    actividades.forEach { unaActividad => unaActividad.realizarActividad(self) }
  }

  method reducirNivelDeIluminacion(unNivelDeIluminacion) {
    nivelDeIluminacion -= unNivelDeIluminacion
  }

  method aumentarNivelDeIluminacion(unNivelDeIluminacion) {
    nivelDeIluminacion += unNivelDeIluminacion
  }

  method agregarHonorifico(unHonorifico) {
    honorificos.add(unHonorifico)
  }

  method decimaParteDeNivelDeIluminacion() = nivelDeIluminacion / 10

  method rejuvenecer(unosDias) {
    diasVividosEsteAnio -= unosDias
  }

  method mitadDeArgumentosEnriquecedores() = self.cantidadDeArgumentosEnriquecedores() / argumentos.count() >= 0.5

  method cantidadDeArgumentosEnriquecedores() = argumentos.filter { unArgumento => unArgumento.esEnriquecedor() }.count()

}
class FilosofoContemporaneo inherits Filosofo {
  override method presentarse() = "hola"

  method nivelDeIluminacion() = if(self.amaAdmirarElPaisaje()) nivelDeIluminacion * 5 else nivelDeIluminacion

  method amaAdmirarElPaisaje() = true // No sé cuándo se supone que ama admirar el paisaje

}


// ACTIVIDADES
class Actividad {
  method realizarActividad(unFilosofo)
}
object tomarVino inherits Actividad {
  
  override method realizarActividad(unFilosofo) {
    unFilosofo.reducirNivelDeIluminacion(10)
    unFilosofo.agregarHonorifico(elBorracho)
  }

}
class JuntarseEnElAgora inherits Actividad {
  
  const otroFilosofo 
  override method realizarActividad(unFilosofo) {
    const unNivelDeIluminacion = otroFilosofo.decimaParteDeNivelDeIluminacion()
    unFilosofo.aumentarNivelDeIluminacion(unNivelDeIluminacion)
  }

}
object admirarElPaisaje inherits Actividad {
  
  override method realizarActividad(_unFilosofo) { /*No hace nada*/ } 

}
class MeditarBajoUnaCascada inherits Actividad {
  
  const metrosDeCascada
  override method realizarActividad(unFilosofo) {
    unFilosofo.aumentarNivelDeIluminacion(10 * metrosDeCascada)
  }

}
class PracticarUnDeporte inherits Actividad {
  
  const deporte
  override method realizarActividad(unFilosofo) {
    unFilosofo.rejuvenecer(deporte.diasRejuvenecidos())
  }

}


// HONORIFICOS
class Honorifico {
  method titulo()
}
object elBorracho inherits Honorifico {
  override method titulo() = "el borracho"
}
object elSabio inherits Honorifico {
  override method titulo() = "el sabio"
}
object cinico inherits Honorifico {
  override method titulo() = "el cínico"
}
object maestro inherits Honorifico {
  override method titulo() = "maestro"
}


// DEPORTES
object futbol {
  method diasRejuvenecidos() = 1
}
class Polo {
  method diasRejuvenecidos() = 2
}
object waterpolo inherits Polo {
  override method diasRejuvenecidos() = super() * 2
}


// DISCUSIONES
class Discusion {
  
  const unPartido
  const otroPartido

  method esBuena() = unPartido.esBueno() and otroPartido.esBueno()
}


// PARTIDOS
class Partido {

  const filosofo

  method esBueno() = filosofo.mitadDeArgumentosEnriquecedores() and filosofo.estaEnLoCorrecto()
}


// ARGUMENTOS
class Argumento {
  const descripcion
  const naturaleza

  method esEnriquecedor() = naturaleza.esEnriquecedora(self)

  method descripcionTieneAlMenosXPalabras(unaCantidadDePalabras) = descripcion.split(" ").size() >= unaCantidadDePalabras
  method descripcionTerminaCon(unSufijo) = descripcion.endsWith(unSufijo)
}
class ArgumentoDeNaturalezasCombinadas inherits Argumento {
  // En este caso "naturaleza" refiere a una lista de naturalezas
  override method esEnriquecedor() = naturaleza.all { unaNaturaleza => unaNaturaleza.esEnriquecedora(self) }
}


// NATURALEZAS
class Naturaleza {
  method esEnriquecedora(unArgumento)
}
object estoica {
  method esEnriquecedora(_unArgumento) = true
}
object moralista {
  method esEnriquecedora(unArgumento) = unArgumento.descripcionTieneAlMenosXPalabras(10)
}
object esceptica {
  method esEnriquecedora(unArgumento) = unArgumento.descripcionTerminaCon("?")
}
object cinica {
  method esEnriquecedora(_unArgumento) = 1.randomUpTo(10) <= 3
}
