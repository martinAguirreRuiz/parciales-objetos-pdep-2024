class Persona {

  const sueniosPendientes = []
  const sueniosCumplidos = []
  const carreraDeseada
  const carrerasEstudiadas = []
  var nivelDeFelicidad = 0
  const tipoDePersona

  method cumplirUnSuenio(unSuenio) {
    if(!sueniosPendientes.contains(unSuenio)) {
      throw new DomainException(message = "No se puede cumplir el suenio")
    }else{
      unSuenio.cumplirse(self)
    }
  }

  method marcarSuenioCumplido(unSuenio) {
    sueniosPendientes.remove(unSuenio)
    sueniosCumplidos.add(unSuenio)
  }

  method carreraDeseada() = carreraDeseada

  method agregarCarreraEstudiada(unaCarrera) {
    carrerasEstudiadas.add(unaCarrera)
  }

  method incrementarFelicidad(unaFelicidad) {
    nivelDeFelicidad += unaFelicidad
  }

  method yaEstudioLaCarrera(unaCarrera) = carrerasEstudiadas.contains(unaCarrera)

  method cumplirSuenioElegido() {
    const suenioElegido = tipoDePersona.elegirSuenio(sueniosPendientes)
    self.cumplirUnSuenio(suenioElegido)
  }

  method esFeliz() = nivelDeFelicidad > self.sumarPotencialFelicidad()

  method sumarPotencialFelicidad() = sueniosPendientes.sum { unSuenio => unSuenio.felicidadAAumentar() }

}

class Suenio {

  const felicidadAAumentar

  method cumplirse(unaPersona)
  method validarSuenio(unaPersona)
  method realizarSuenio(unaPersona)

  method felicidadAAumentar() = felicidadAAumentar
  
}

class Recibirse inherits Suenio {

  const carrera = ingenieriaEnSistemas

  override method cumplirse(unaPersona) {
    
    self.validarSuenio(unaPersona)
    self.realizarSuenio(unaPersona)
    unaPersona.marcarSuenioCumplido(self)
    unaPersona.incrementarFelicidad(felicidadAAumentar)

  }

  override method validarSuenio(unaPersona) {
    if(unaPersona.carreraDeseada() != carrera){
      throw new DomainException(message = "La persona no quiere estudiar esta carrera")
    }else if(unaPersona.yaEstudioLaCarrera(carrera)){
      throw new DomainException(message = "Esta persona ya se recibió de esta carrera")
    }
  }

  override method realizarSuenio(unaPersona) {
    unaPersona.agregarCarreraEstudiada(ingenieriaEnSistemas)
  }
}

class SuenioMultiple inherits Suenio {

  const suenios

  override method cumplirse(unaPersona) {
    
    self.validarSuenio(unaPersona)
    self.realizarSuenio(unaPersona)

  }

  override method validarSuenio(unaPersona) {
    suenios.forEach { unSuenio => unSuenio.validarSuenio(unaPersona) }
  }

  override method realizarSuenio(unaPersona) {
    suenios.forEach { unSuenio => unSuenio.cumplirse(unaPersona) }
  }

  
}
object ingenieriaEnSistemas {
}
object odontologia {
}
object psicologia {
}

object realista {
  method elegirSuenio(sueniosPendientes) = sueniosPendientes.max { unSuenio => unSuenio.felicidadAAumentar() }
}
object alocado {
  method elegirSuenio(sueniosPendientes) = sueniosPendientes.anyOne()
}
object obsesivo {
  method elegirSuenio(sueniosPendientes) = sueniosPendientes.first()
}