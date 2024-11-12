import src.Descuento.*

object plataforma {

    const juegos = #{}

    method aplicarDescuentoDirectoAJuegosCaros(unPorcentaje) {
        const juegosCaros = self.obtenerJuegosCaros()
        self.aplicarDescuentoDirectoUnoAUno(juegosCaros, unPorcentaje)
    }

    method obtenerJuegosCaros() = juegos.filter { unJuego => unJuego.precio() > self.precioMasCaro() }
  
    method precioMasCaro() = juegos.max { unJuego => unJuego.precio() }

    method aplicarDescuentoDirectoUnoAUno(juegosCaros, unPorcentaje) {

        const descuentoAAplicar = if(unPorcentaje > 100) gratis else new DescuentoDirecto(porcentajeDeDescuento = unPorcentaje)

        juegosCaros.forEach { unJuego => unJuego.descuento(descuentoAAplicar) }
        
    }

}