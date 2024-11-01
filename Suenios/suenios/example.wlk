class Persona {

  const sueniosPendientes = []
  const sueniosCumplidos = []
  const carreraDeseada
  const carrerasEstudiadas = []
  var nivelDeFelicidad = 0

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

}

class Suenio {

  const felicidadAAumentar

  method cumplirse(unaPersona)
  method validarSuenio(unaPersona)
  method realizarSuenio(unaPersona)

  method felicidadAAumentar() = felicidadAAumentar
  
}

class RecibirseDeIngenieroEnSistemas inherits Suenio {

  override method cumplirse(unaPersona) {
    
    self.validarSuenio(unaPersona)
    self.realizarSuenio(unaPersona)
    unaPersona.marcarSuenioCumplido(self)
    unaPersona.incrementarFelicidad(felicidadAAumentar)

  }

  override method validarSuenio(unaPersona) {
    if(unaPersona.carreraDeseada() != ingenieriaEnSistemas){
      throw new DomainException(message = "La persona no quiere estudiar Ingenieria en Sistemas")
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