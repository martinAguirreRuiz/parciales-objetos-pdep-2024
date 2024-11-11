import src.Reserva.*
import src.Operacion.*

class Inmueble {

    var reserva
    var operacion
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
        unEmpleado.agregarOperacion(operacion)
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

class Local inherits Casa {

    var tipo
    // const operacion = new Alquiler(mesesAAlquilar = 12)

    override method valorDelInmueble() = tipo.valorDelInmueble(super())

}

object galpon {

    method valorDelInmueble(unValorDeInmueble) = unValorDeInmueble / 2
  
}

object aLaCalle {

    const montoFijo = 100000
    method valorDelInmueble(_unValorDeInmueble) = montoFijo
  
}