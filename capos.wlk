import wollok.vm.*
object rolando {
    const hogar = castilloDePiedra
    const historialDeArtefactos = []
    var property mochila = []
    var enemigosErethia = [archibaldo, astra, caterina]
    var property poderBase = 5
    var tamañoDeMochila = 2
    
    method historialDeArtefactos() = historialDeArtefactos 
    method poderDePelea() = poderBase + mochila.map({artefacto => artefacto.poderArtefacto(self)}).sum()
    method poderDeArtefactoMasPoderoso() = hogar.almacenDeArtefactos().map({artefacto => artefacto.poderArtefacto(self)}).max()

    method tieneElArtefacto(artefacto) {
        return self.todosLosArtefactos().contains(artefacto) 
    }

    method tieneArtefactoFatal(enemigo) {
      return not self.artefactosFatales(enemigo).isEmpty()
    }

    method artefactosFatales(enemigo) {
      return mochila.filter({artefacto => poderBase + artefacto.poderArtefacto(self) > enemigo.poder()})
    }

    method enemigosQuePuedeVencer(){
        return enemigosErethia.filter({enemigo => self.poderDePelea() > enemigo.poder()})
    }
    
    method moradasConquistables() {
        return self.enemigosQuePuedeVencer().map({enemigo => enemigo.hogar()})
    }

    method batallar() {
        mochila.forEach({artefacto => artefacto.usar()})
        poderBase += 1
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

    method usar() {
      vecesUsada += 1
    }
    
    method poderArtefacto(personaje) {
        if(vecesUsada == 0){
            return personaje.poderBase()
        } else {
            return personaje.poderBase() / 2
        }
    }
}

object collarDivino {
    var property vecesUsada = 0
    var property poderBaseArtefacto = 3 

    method usar() {
      vecesUsada += 1
    }

    method poderArtefacto(personaje) {
        if(personaje.poderBase() > 6){
            return poderBaseArtefacto + vecesUsada
        } else {
            return poderBaseArtefacto
        }
    }
}

object armaduraDeAceroValyrio {
    var property vecesUsada = 0
    var property poderBaseArtefacto = 6

    method usar() {
      vecesUsada += 1
    }

    method poderArtefacto(personaje) {
        return poderBaseArtefacto
    }
}

object libroDeHechizos {
    var hechizos = []
    var property vecesUsada = 0 

    method usar() {
      vecesUsada += 1
      hechizos = hechizos.drop(1)
    }

    method añadirHechizo(hechizo) {
      hechizos.add(hechizo)
    }

    method poderArtefacto(personaje) {
        if(hechizos.isEmpty()){
            return 0
        } else {
            return hechizos.head().unidadesDePoder(personaje)
        }
    }
}

object hechizoBendicion {
    method unidadesDePoder(personaje) = 4 
}

object hechizoInvisibilidad {
  method unidadesDePoder(personaje) = personaje.poderBase()  
}

object hechizoInvocacion {
    method unidadesDePoder(personaje) = personaje.poderDeArtefactoMasPoderoso()
}

object caterina {
    method poder() = 28
    method hogar() = fortalezaDeAcero 
}

object fortalezaDeAcero {
  
}

object archibaldo {
    method poder() = 16
    method hogar() = palacioDeMarmol  
}

object palacioDeMarmol {
  
}

object astra {
    method poder() = 14
    method hogar() = torreDeMarfil  
}

object torreDeMarfil {
  
}