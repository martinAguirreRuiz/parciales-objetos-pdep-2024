class CastaSocial {

    method puedeSubirAExpedicion(unVikingo) = true
  
}
object thrall inherits CastaSocial{
  
}

object karl inherits CastaSocial{

}

object jarl inherits CastaSocial{
    override method puedeSubirAExpedicion(unVikingo) = !unVikingo.tieneArmas()
}
