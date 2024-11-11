class Operacion {
  const valorInmueble
  method comision() 
}

class Alquiler inherits Operacion {

  const mesesAAlquilar
  override method comision() = (mesesAAlquilar * valorInmueble) / 50000
  
}

class Venta inherits Operacion {
  
  var porcentajePorVenta
  override method comision() = valorInmueble * porcentajePorVenta

}