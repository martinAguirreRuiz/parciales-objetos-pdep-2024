import src.Descuento.*
class Juego {

    const precioEnUsd
    var descuento = sinDescuento

    method precio() = precioEnUsd - descuento.aplicarDescuento(precioEnUsd)
    method descuento(unDescuento) { descuento = unDescuento }
  
}

