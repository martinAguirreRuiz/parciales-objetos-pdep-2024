class Empleado {

  var totalDeComisiones = 0
  var totalDeOperacionesCerradas = 0
  var totalDeReservas = 0

  method totalDeUnCriterio(unCriterio) = unCriterio // Esto puede ser total de comisiones, operaciones cerradas o reservas

  method realizarOperacion(unInmueble, unCliente) {
    unInmueble.puedeRealizarLaOperacion(unCliente)
    unInmueble.realizarOperacion(self)
    totalDeOperacionesCerradas += 1
  }

  method sumarComision(unaComision) {
    totalDeComisiones += unaComision
  }

  method reservarInmueble(unInmueble, unCliente) {
    unInmueble.reservarse(unCliente)
    totalDeReservas += 1
  }
  
}