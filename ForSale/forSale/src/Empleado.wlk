class Empleado {

  var totalDeComisiones = 0
  var totalDeOperacionesCerradas = 0
  var totalDeReservas = 0
  const operacionesRealizadas = #{}

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

  method tieneProblemasCon(unEmpleado) = self.ambosCerraronOperacionesEnUnaZona(unEmpleado) and self.algunoConcretoOperacionDelOtro(unEmpleado)

  method ambosCerraronOperacionesEnUnaZona(unEmpleado) = self.zonasOperadas().any { unaZona => unEmpleado.operoEnZona(unaZona) }

  method zonasOperadas() = operacionesRealizadas.map { unaOperacion => unaOperacion.zona() }

  method operoEnZona(unaZona) = self.zonasOperadas().contains(unaZona)

  // TODO
  method algunoConcretoOperacionDelOtro(unEmpleado) = true
  
}