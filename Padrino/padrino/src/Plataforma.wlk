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
        const sumaDePreciosLocal = self.sumaDePreciosLocal(unPais, juegosAptos)
        const promedio = sumaDePreciosLocal / juegosAptos.size()
        return promedio
        
    }

    method obtenerJuegosAptos(unPais) = juegos.filter { unJuego => unPais.esAptoParaMenores(unJuego) }

    method sumaDePreciosLocal(unPais, juegosAptos) = juegosAptos.sum { unJuego => unPais.precioLocal(unJuego.precio()) }

}