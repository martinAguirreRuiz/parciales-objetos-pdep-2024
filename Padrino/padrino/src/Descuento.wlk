class DescuentoDirecto {
  
    const porcentajeDeDescuento

    method aplicarDescuento(unPrecio) = unPrecio * porcentajeDeDescuento

}

class DescuentoFijo {

    const montoFijo

    method aplicarDescuento(unPrecio) = (unPrecio / 2).max(montoFijo)

}

class Gratis {
  
    method aplicarDescuento(unPrecio) = unPrecio

}