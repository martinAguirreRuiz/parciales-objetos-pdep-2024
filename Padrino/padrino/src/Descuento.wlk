class Descuento {
    method aplicarDescuento(unPrecio) = 0
}

class DescuentoDirecto inherits Descuento {
    const porcentajeDeDescuento
    override method aplicarDescuento(unPrecio) = unPrecio * (porcentajeDeDescuento.min(100)/100)
}

class DescuentoFijo inherits Descuento {
    const montoFijo
    override method aplicarDescuento(unPrecio) = (unPrecio / 2).max(montoFijo)
}

object gratis inherits Descuento {
    override method aplicarDescuento(unPrecio) = unPrecio
}

object sinDescuento inherits Descuento {
    override method aplicarDescuento(_unPrecio) = 0
}

class SuperDescuentoFijo inherits DescuentoFijo {

    override method aplicarDescuento(unPrecio) = super(unPrecio) * 1.10 // Hace un 10% de descuento más sobre el descuento fijo

} 