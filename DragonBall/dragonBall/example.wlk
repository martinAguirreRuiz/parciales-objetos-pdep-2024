class Guerrero {

  const potencialOfensivo
  var energia
  var experiencia
  const energiaOriginal = energia

  method atacar(unGuerrero) {
    unGuerrero.esAtacado(self)
  }

  method esAtacado(unGuerrero) {
    energia -= unGuerrero.porcentajeDelPotencialOfensivo(10)
    experiencia += 1
  }

  method porcentajeDelPotencialOfensivo(unPorcentaje) = potencialOfensivo * (unPorcentaje/100)

  method comerSemillaDelErmitanio() {
    energia = energiaOriginal
  }
}