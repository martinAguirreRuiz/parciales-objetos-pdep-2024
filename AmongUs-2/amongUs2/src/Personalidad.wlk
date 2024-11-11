import src.Nave.*
object troll {
    method votar() = nave.cualquierJugadorNoSospechoso()
}
object detective {
    method votar() = nave.jugadorConMayorSospecha()
}
object materialista {
    method votar() = nave.cualquierJugadorSinCosas()
}