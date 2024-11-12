import src.Descuento.*
class Juego {

    const precioEnUsd
    var descuento = sinDescuento
    const caracteristicas
    const criticas

    method precio() = precioEnUsd - descuento.aplicarDescuento(precioEnUsd)
    method descuento(unDescuento) { descuento = unDescuento }

    method contieneCaracteristicasProhibidas(unasCaracteristicas) = 
        unasCaracteristicas.any { unaCaracteristica => caracteristicas.contains(unaCaracteristica) }

    method registrarCritica(unaCritica) {
        criticas.add(unaCritica)
    }

}

