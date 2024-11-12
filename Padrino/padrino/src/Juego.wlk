class Juego {

    const precioEnUsd
    var descuento

    method precio() = precioEnUsd - descuento.aplicarDescuento(precioEnUsd)
  
}

