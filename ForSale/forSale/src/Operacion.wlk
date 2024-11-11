class Operacion {
  method comision(unValorDeInmueble) 
}
 
class Alquiler inherits Operacion {

  const mesesAAlquilar
  override method comision(unValorDeInmueble) = (mesesAAlquilar * unValorDeInmueble) / 50000
  
}

class Venta inherits Operacion {
  
  var porcentajePorVenta
  override method comision(unValorDeInmueble) =  unValorDeInmueble * porcentajePorVenta

}