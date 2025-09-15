import wollok.vm.*
object rolando {
    const mochila = []
    const hogar = castilloDePiedra
    const historialDeArtefactos = []
    const property poderBase = 5
    var tamañoDeMochila = 2
    
    method mochila() = mochila
    method historialDeArtefactos() = historialDeArtefactos 
    method poderDePelea() = poderBase + mochila.map({artefacto => artefacto.poderArtefacto()}).sum()

    method tieneElArtefacto(artefacto) {
        return self.todosLosArtefactos().contains(artefacto) 
    }

    method batallar() {
      
    }

    method todosLosArtefactos() {
        return hogar.todosLosArtefactos(mochila)
    }
        
    method tamañoDeMochila(unTamaño) {
      tamañoDeMochila = unTamaño
    }   

    method llegarAlCastilloYGuardar() {
        hogar.guardarTodosLosArtefactos(mochila)
        self.vaciarMochila()
    }

    method vaciarMochila() {
      mochila.clear()
    }

    method encontrarArtefacto(artefacto) {
        historialDeArtefactos.add(artefacto)
        self.puedeLevantar()
        mochila.add(artefacto)
    }

    method puedeLevantar() {
      if(mochila.size() >= tamañoDeMochila){
        self.error("el artefacto no entra en la mochila")
      }
    }
}

object castilloDePiedra{
    const almacenDeArtefactos = []

    method almacenDeArtefactos() = almacenDeArtefactos 

    method todosLosArtefactos(mochila) {
        return almacenDeArtefactos + mochila
     }

    method guardarTodosLosArtefactos(mochila) {
        almacenDeArtefactos.addAll(mochila)
    }
}

object espadaDelDestino { 
    var property vecesUsada = 0 

    method poderArtefacto(personaje) {
        if(vecesUsada == 0){
            return personaje.poderBase()
        } else {
            return personaje.poderBase() / 2
        }
    }
}

object libroDeHechizos {
    
}

object collarDivino {
    var property vecesUsada = 0

    method poderArtefacto(personaje) {
        if(personaje.poderBase() > 6){
            return 3 + vecesUsada
        } else {
            return 3
        }
    }
}

object armaduraDeAceroValyrio {
    var property vecesUsada = 0

    method poderArtefacto(personaje) {
        return 6
    }
}