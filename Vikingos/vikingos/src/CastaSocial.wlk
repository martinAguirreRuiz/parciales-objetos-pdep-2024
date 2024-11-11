class CastaSocial {

    method puedeSubirAExpedicion(unVikingo) = true

    method escalarClaseSocial(unVikingo) {
      /* No hace nada */
    }
  
}
object thrall inherits CastaSocial{
  
}

object karl inherits CastaSocial{
    override method escalarClaseSocial(unVikingo) { unVikingo.claseSocial(thrall) }
}

object jarl inherits CastaSocial{
    
    override method puedeSubirAExpedicion(unVikingo) = !unVikingo.tieneArmas() 

    override method escalarClaseSocial(unVikingo) {
        unVikingo.claseSocial(karl)
        unVikingo.efectosDeClaseMedia()
    }

}
