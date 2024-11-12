class Pais {

    const caracteristicasProhibidas
    const tasaDeConversionDolares

    method esAptoParaMenores(unJuego) = ! unJuego.contieneCaracteristicasProhibidas(caracteristicasProhibidas)

    method precioLocal(unPrecioEnDolares) = unPrecioEnDolares * tasaDeConversionDolares
  
}