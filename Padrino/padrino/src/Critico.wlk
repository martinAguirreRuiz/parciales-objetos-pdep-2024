import src.Critica.*
class Usuario {

    method registarCriticaPositiva(unJuego) {
        const unaCritica = new Critica()
        unaCritica.agregarTexto("SI")
        unJuego.registrarCritica(unaCritica)
    }

    method registarCriticaNegativa(unJuego) {
        const unaCritica = new Critica()
        unaCritica.agregarTexto("NO")
        unJuego.registrarCritica(unaCritica)
    }
  
}

class CriticoPago {

    const juegosQuePagaron

    method registrarCritica(unJuego) {

        
      
    }
  
}