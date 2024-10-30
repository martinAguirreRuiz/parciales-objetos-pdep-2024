class Guerrero {

  const potencialOfensivo
  var energia
  var experiencia
  const energiaOriginal = energia
  const traje

  method atacar(unGuerrero) {
    unGuerrero.esAtacado(self)
  }

  method esAtacado(unGuerrero) {
    self.sufrirPerdidaEnergia(unGuerrero)
    self.sufrirGananciaDeExperiencia()
    traje.sufrirDesgaste()
  }

  method sufrirPerdidaEnergia(unGuerrero) {
    energia -= self.calcularDanioRecibido(unGuerrero)
  }

  method sufrirGananciaDeExperiencia() {
    experiencia += self.calcularGananciaDeExperiencia()
  }

  method calcularDanioRecibido(unGuerrero) {
    const danioRecibido = unGuerrero.porcentajeDelPotencialOfensivo(10)
    return traje.disminuirDanioRecibido(danioRecibido)
  }

  method calcularGananciaDeExperiencia() = traje.aumentarGananciaDeExperiencia(1)

  method porcentajeDelPotencialOfensivo(unPorcentaje) = potencialOfensivo * (unPorcentaje/100)

  method comerSemillaDelErmitanio() {
    energia = energiaOriginal
  }
}

class Traje {
  
  var nivelDeDesgaste = 0

  method sufrirDesgaste() {
    nivelDeDesgaste += 5
  }

  method disminuirDanioRecibido(unDanioRecibido)

  method aumentarGananciaDeExperiencia(unAumentoDeExperiencia)

  method trajeNoEstaDesgastado() = nivelDeDesgaste < 100
}

class TrajeComun inherits Traje {

  const porcentajeDeProteccion

  override method disminuirDanioRecibido(unDanioRecibido) = 
    if(self.trajeNoEstaDesgastado()) unDanioRecibido - unDanioRecibido * (porcentajeDeProteccion/10) else unDanioRecibido

  override method aumentarGananciaDeExperiencia(_unAumentoDeExperiencia) = _unAumentoDeExperiencia
  
}

class TrajeDeEntrenamiento inherits Traje {

  override method disminuirDanioRecibido(_unDanioRecibido) = _unDanioRecibido

  override method aumentarGananciaDeExperiencia(unAumentoDeExperiencia) = 
    if(self.trajeNoEstaDesgastado()) unAumentoDeExperiencia * 2 else unAumentoDeExperiencia

}

class TrajeModularizado inherits Traje {

  const piezas

  override method sufrirDesgaste() {
    // Esto debería ser un override, porque habría que manejar el desgaste cada pieza del traje (no especifica la consigna)
  }

  override method disminuirDanioRecibido(unDanioRecibido) = 
    if(self.trajeNoEstaDesgastado()) self.sumatoriaDeResistenciasDePiezasNoDesgastadas() else unDanioRecibido

  override method trajeNoEstaDesgastado() = piezas.any { pieza => pieza.noEstaDesgastada() }

  method sumatoriaDeResistenciasDePiezasNoDesgastadas() = piezas.sum { pieza => pieza.resistencia() }

  override method aumentarGananciaDeExperiencia(unAumentoDeExperiencia) = self.porcentajeDePiezasNoGastadas() * unAumentoDeExperiencia

  method porcentajeDePiezasNoGastadas() = self.cantidadDePiezasNoGastadas() / piezas.count()

  method cantidadDePiezasNoGastadas() = (piezas.filter { unaPieza => unaPieza.noEstaDesgastada() }).count()
}

class Pieza {

  var nivelDeDesgaste 
  const nivelDeResistencia

  method sufrirDesgaste() {
    // Debería haber un método acá que me permita que sufra un desgaste la pieza para que tenga sentido el "var" en "nivelDesgaste" (no especifica en la consigna)
  }

  method noEstaDesgastada() = nivelDeDesgaste < 20

  method nivelDeResistencia() = if(self.noEstaDesgastada()) nivelDeResistencia else 0

}