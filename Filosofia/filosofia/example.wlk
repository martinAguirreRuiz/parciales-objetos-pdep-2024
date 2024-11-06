class Filosofo {

  const nombre
  const honorificos

  method presentarse() = self.honorificosFormateados() + " " + nombre
  
  method honorificosFormateados() = honorificos.join(",")

}