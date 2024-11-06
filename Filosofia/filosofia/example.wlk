class Filosofo {

  const nombre
  const honorificos
  var nivelDeIluminacion

  method presentarse() = self.honorificosFormateados() + " " + nombre
  
  method honorificosFormateados() = honorificos.join(",")

  method estaEnLoCorrecto() = nivelDeIluminacion > 1000

}