import src.Descuento.*

object plataforma {

    const juegos = #{}

    method aplicarDescuentoDirectoAJuegosCaros(unPorcentaje) {
        const juegosCaros = self.obtenerJuegosCaros()
        self.aplicarDescuentoDirectoUnoAUno(juegosCaros, unPorcentaje)
    }

    method obtenerJuegosCaros() = juegos.filter { unJuego => unJuego.precio() > self.precioMasCaro() * 0.75 }
  
    method precioMasCaro() = juegos.max { unJuego => unJuego.precio() }

    method aplicarDescuentoDirectoUnoAUno(juegosCaros, unPorcentaje) {

        const descuentoAAplicar = if(unPorcentaje > 100) gratis else new DescuentoDirecto(porcentajeDeDescuento = unPorcentaje)

        juegosCaros.forEach { unJuego => unJuego.descuento(descuentoAAplicar) }

    }

    method promedioPrecioFinal(unPais) {
    
        const juegosAptos = self.obtenerJuegosAptos(unPais)
        const sumaDePrecios = self.sumaDePrecios(juegosAptos)
        const promedio = sumaDePrecios / juegosAptos.size()
        return unPais.precioLocal(promedio)
        
    }

    method obtenerJuegosAptos(unPais) = juegos.filter { unJuego => unPais.esAptoParaMenores(unJuego) }

    method sumaDePrecios(juegosAptos) = juegosAptos.sum { unJuego => unJuego.precio() }

}