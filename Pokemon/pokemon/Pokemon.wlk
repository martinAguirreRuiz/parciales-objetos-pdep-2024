import pokemon.Condicion.*

class Pokemon {

  var vida
  const vidaMaxima
  const movimientos
  var condicion

  method grositud() = self.vidaMaxima() * self.sumaPoderMovimientos()

  method vidaMaxima() = vidaMaxima

  method sumaPoderMovimientos() = movimientos.sum { unMovimiento => unMovimiento.poder() }

  method recuperarVida(unaCantidadDeVida) {
    vida = (vida + unaCantidadDeVida).min(vidaMaxima)
  }

  method recibirDanio(unDanio) {
    vida = 0.max(vida-unDanio)
  }

  method condicion(unaCondicion) { condicion = unaCondicion }

  method lucharContra(unPokemon) {
    self.estaVivo()
    condicion.permiteElMovimiento()
    const unMovimiento = self.movimientoDisponible()
    unMovimiento.serUtilizado(self, unPokemon)
  }

  method movimientoDisponible() = movimientos.findOrElse (
    { unMovimiento => unMovimiento.estaDisponible() }, 
    { throw new DomainException(message = "No se encontraron movimientos disponibles") }
  )

  method estaVivo() { if (vida == 0) throw new DomainException(message = "El pokemon está muerto") }

  method normalizar() { self.condicion(normal) }

}