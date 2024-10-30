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