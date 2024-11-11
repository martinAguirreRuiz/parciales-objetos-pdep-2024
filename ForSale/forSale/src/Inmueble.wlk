import src.Reserva.*

class Inmueble {

    var reserva
    const operacion
    const metrosCuadrados
    const cantidadDeAmbientes
    const zona

    method reservarse(unCliente) {
        reserva = new Reserva(cliente = unCliente)
    }

    method puedeRealizarLaOperacion(unCliente) {
        if(self.estaReservado() and ! reserva.estaReservadoPor(unCliente)){
            throw new DomainException(message = "Inmueble reservado por otro cliente, no se puede realizar la operación")
        }
    }

    method estaReservado() = reserva != null

    method realizarOperacion(unEmpleado) {
        const comision = operacion.comision(self.valorDelInmueble())
        unEmpleado.sumarComision(comision)
    }

    method valorDelInmueble() = zona.valorPorZona()

}

class Casa inherits Inmueble {
    
    const valorDelInmueble
    override method valorDelInmueble() = super() + valorDelInmueble

}

class PentHouse inherits Inmueble {

    override method valorDelInmueble() = super() + 500000.min(14000 * metrosCuadrados)
  
}

class Departamento inherits Inmueble {

    override method valorDelInmueble() = super() + 350000 * cantidadDeAmbientes
  
}