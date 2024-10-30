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
  
  method disminuirDanioRecibido(unDanioRecibido)

  method aumentarGananciaDeExperiencia(unAumentoDeExperiencia)
}

class TrajeComun inherits Traje {

  const porcentajeDeProteccion

  override method disminuirDanioRecibido(unDanioRecibido) = unDanioRecibido - unDanioRecibido * (porcentajeDeProteccion/10)

  override method aumentarGananciaDeExperiencia(_unAumentoDeExperiencia) = _unAumentoDeExperiencia
  
}

class TrajeDeEntrenamiento inherits Traje {

  override method disminuirDanioRecibido(_unDanioRecibido) = _unDanioRecibido

  override method aumentarGananciaDeExperiencia(unAumentoDeExperiencia) = unAumentoDeExperiencia * 2

}