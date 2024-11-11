class Condicion {
  method poder()

  method permiteElMovimiento(unPokemon) { 
    if(!self.lograMoverse())  
      throw new DomainException (message = "La condicion no permite mover al Pokemon")
  }

  method lograMoverse() = 0.randomUpTo(2).roundUp().even()

}
object suenio inherits Condicion {
  override method poder() = 50

  override method permiteElMovimiento(unPokemon) {
    super(unPokemon)
    unPokemon.normalizar()
  }

}

object paralisis inherits Condicion {
  override method poder() = 30
}

object normal inherits Condicion {

  override method poder() = 1

  override method permiteElMovimiento(_unPokemon) { /* No hace nada */ }

}

class Confusion inherits Condicion {

  const turnosConfundido

  override method poder() = 40 + turnosConfundido
  override method permiteElMovimiento(unPokemon) { 
    try{
      super(unPokemon)
    } 
    catch e : DomainException {
      unPokemon.recibirDanio(20)
      throw new DomainException(message = "No se pudo mover y sufrió danio")
    } then always {
      self.pasarUnTurno(unPokemon)
    }
  }

  method pasarUnTurno(unPokemon) {
    if(turnosConfundido > 1){
      unPokemon.condicion(new Confusion(turnosConfundido = turnosConfundido -1)) 
      // Con esto hago a la Confusion inmutable
    }else{
      unPokemon.normalizar()
    }
  }




}