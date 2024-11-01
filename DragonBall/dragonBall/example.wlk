class Guerrero {

  var potencialOfensivo
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

  method potencialOfensivo() = potencialOfensivo

  method elementosEnSuTraje() = traje.elementos()

}

class Saiyan inherits Guerrero {
  
  var nivelDeSaiyan = 0 // Empieza en estado base
  const potencialOfensivoOriginal = potencialOfensivo
  const porcentajesDanioSegunNivel = [10, 5, 3, 0]

  
  method convertirseEnSuperSaiyan(unNivel) {
    if(nivelDeSaiyan == 0){
      potencialOfensivo *= 1.5
      nivelDeSaiyan = unNivel
    }
  }

  override method esAtacado(unGuerrero) {
    //super() //Lo comento porque da error, no sé por que
    self.chequearEnergia()
  }

  override method calcularDanioRecibido(unGuerrero) {
    const porcentajeDeDanio = porcentajesDanioSegunNivel.get(nivelDeSaiyan)
    const danioRecibido = unGuerrero.porcentajeDelPotencialOfensivo(porcentajeDeDanio)
    return traje.disminuirDanioRecibido(danioRecibido)
  }

  method volverAEstadoBase() {
    if(nivelDeSaiyan != 0){
      potencialOfensivo *= 0.6666
    }
  }

  method chequearEnergia() {
    if(self.energiaBaja()){
      self.volverAEstadoBase()
    }
  }

  method energiaBaja() = energia <= energiaOriginal * 0.01

  override method comerSemillaDelErmitanio() {
    super()
    self.aumentarPotencialOfensivo()
  }

  method aumentarPotencialOfensivo() {
    potencialOfensivo += potencialOfensivoOriginal * 0.05
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

  method elementos() = 1
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

  override method elementos() = piezas.count()
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

class Modalidad {

  const peleadores

  method seleccionarPeleadores()
}

object powerIsBest inherits Modalidad(peleadores = []) {
  
  override method seleccionarPeleadores() = self.ordenarPeleadoresPorMayorPoder().take(16)

  method ordenarPeleadoresPorMayorPoder() = self.ordenarPeleadoresPorMenorPoder().reverse()

  method ordenarPeleadoresPorMenorPoder() = peleadores.sortedBy { unPeleador => unPeleador.potencialOfensivo() }
  
}

object funny inherits Modalidad(peleadores = []) {
  
  override method seleccionarPeleadores() = self.peleadoresConMasElementosEnSusTrajes().take(16)

  method peleadoresConMasElementosEnSusTrajes() = self.peleadoresConMenosElementosEnSusTrajes().reverse()

  method peleadoresConMenosElementosEnSusTrajes() = peleadores.sortedBy { unPeleador => unPeleador.elementosEnSuTraje() }
  
}

object surprise inherits Modalidad(peleadores = []) {

  override method seleccionarPeleadores() = self.seleccionarPeleadoresRecursivo([])

  method seleccionarPeleadoresRecursivo(peleadoresRandom) {
    if(peleadoresRandom.size() == 16){
      return peleadoresRandom
    }else{
      const peleadorRandom = peleadores.anyOne()
      if(! peleadoresRandom.contains(peleadorRandom)){
        peleadoresRandom.add(peleadorRandom)
      }
      return self.seleccionarPeleadoresRecursivo(peleadoresRandom)
    }
  }
}
