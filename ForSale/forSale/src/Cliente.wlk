class Cliente {

    method solicitarReserva(unInmueble, unEmpleado) {
        unEmpleado.reservarInmueble(unInmueble, self)
    }

    method solicitarOperacion(unInmueble, unEmpleado) {
        unEmpleado.realizarOperacion(unInmueble, self)
    }
  
}