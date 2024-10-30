class Persona{
    var monedas = 20
    var property edad //es metodo y variable al mismo tiempo. ejemplo.edad(x) para modificarlo

    method trabajar(tiempo,planeta)

    method destacado(){
        return self.edadDestacada() && self.recursos() > 30
    }

    method edadDestacada(){
        return  edad > 18 &&  edad < 65
    }

    method gastar (monto){
        if (monto >= monedas) { // es correcto hacer un .max(0) o tirar excepcion
            self.error("No se cuenta con la cantidad de recursos requerida")
         }
        monedas = monedas - monto
    }

    method ganar (monto){
        monedas = monedas + monto
    }

    method cumplirAnios(){
        edad = edad + 1
    }

    method recursos()=monedas
}

class Construccion{
    method valor ()
}

class Muralla inherits Construccion{
    var longitud
    override method valor (){
        return 10 * longitud
    }
}

class Museo inherits Construccion {
    var superficie
    var indiceDeImportancia

    override  method valor (){
        return superficie * indiceDeImportancia
    }
}

class Planeta {
    const habitantes = new List()
    const construcciones = new List()

    method delegacionDiplomatica(){
        const delegacion = habitantes.filter({habitante => habitante.destacado()}) 
        const habitanteMasRico = habitantes.max{habitante => habitante.recursos()}
        if(!delegacion.contains(habitanteMasRico)){
            delegacion.add(habitanteMasRico)
        }
        return delegacion
    }
    method esValioso(){
        const valorTotal = construcciones.sum({construccion => construccion.valor()})
        return valorTotal > 100
    }

    method agregarConstruccion(construccion){
        construcciones.add(construccion)
    }

    method delegacionTrabajar(tiempo) {
        self.delegacionDiplomatica().forEach{delegado=>delegado.trabajar(tiempo,self)}
    }

    method invadir(planeta,tiempo){
        planeta.delegacionDiplomatica().forEach{delegadoInvadido=>delegadoInvadido.trabajar(tiempo,self)}
    }
}

/////////////////PRUEBA/////////////////////////////////////
const uno = new Persona (edad = 20, monedas = 31)
const dos = new Persona (edad = 30, monedas = 32)
const tres = new Persona (edad = 25, monedas = 80)
const cuatro = new Persona (edad = 80, monedas = 30)

const murallaUno = new Muralla(longitud = 30)
const murallaDos = new Muralla(longitud = 50)
const museoUno = new Museo(superficie = 15, indiceDeImportancia = 2)

const tierra = new Planeta (habitantes = [uno,dos,tres,cuatro] , construcciones = [murallaUno,murallaDos,museoUno])

const cinco = new Persona(edad = 20, monedas = 10)
const seis = new Persona(edad = 19, monedas = 60)
const museoDos = new Museo (superficie = 15, indiceDeImportancia = 3)
const marte = new Planeta (habitantes = [cinco,seis], construcciones = [museoDos])
//cinco.ganar(100)

/////////////////////////////////////////////////////
class Productor inherits Persona(edad=50){ //Otra forma de darle valor a var heredada
    const tecnicas  = [cultivo]
    const viveEnPlaneta

    override method recursos(){
        return super()*tecnicas.size()
    }

    override method destacado(){
        return super() ||  tecnicas.size() > 5
    }

    method conoce(tecnica) = tecnicas.elem(tecnica)

    method realizar(tecnica,tiempo){
        if(!self.conoce(tecnica)){
            monedas = monedas - 1 
        } else {
            monedas = monedas + 3 * tiempo
        }
    }

    method aprender(tecnica){
        tecnicas.add(tecnica)
    }
    override method trabajar(tiempo,planeta){
        if(planeta != viveEnPlaneta ){
            self.error("No vive en el planeta indicado")
        }
        self.realizar(tecnicas.last(),tiempo)
     }

//    method initialize(){ metodo q se corre en cuanto se instancia la clase
//       edad = 50
//    } asi se da valor a una variable heredada

}

class Constructor inherits Persona{
    var cantidadConstrucciones
    var viveEnRegion
    var property inteligencia 

    override method recursos(){
        return super()+10*cantidadConstrucciones
    }

    override method destacado(){
        return cantidadConstrucciones > 5
    }

    override method trabajar(tiempo,planeta){
        monedas = monedas -5
        viveEnRegion.trabajar(tiempo,planeta,self)
    }
}

class montania{
    method trabajar(tiempo,planeta,trabajador){
        const murallaConstruida = new Muralla(longitud =  tiempo/2)
        planeta.agregarConstrccion(murallaConstruida)
    }
}

class costa{
    method trabajar(tiempo,planeta,trabajador){
        const museoConstruido = new Museo (superficie = tiempo, indiceDeImportancia = 1)
        planeta.agregarConstruccion(museoConstruido)
    }
}

class llanura{
    method trabajar(tiempo,planeta,trabajador){
        if(!trabajador.destacado()){
            montania.trabajar(tiempo,planeta,trabajador)
        } else {
            const museoConstruido = new Museo(superficie = tiempo, indiceDeImportancia = trabajador.recursos()/5)
            planeta.agregarConstruccion(museoConstruido)
        }
    }
}

class desierto{
    method trabajar(tiempo,planeta,trabajador){
        const murallaConstruida = new Muralla (longitud = trabajador.inteligencia() * 2)
    }
}


///////////////////////////////PRUEBA////////////////////////////////////
const Montania = new montania()
const constructorUno = new Constructor(edad = 30, monedas = 100, cantidadConstrucciones = 3, viveEnRegion = Montania, inteligencia = 10)
const constructorDos = new Constructor(edad = 40, monedas = 150, cantidadConstrucciones = 6, viveEnRegion = new costa(), inteligencia = 15)
const constructorTres = new Constructor(edad = 35, monedas = 120, cantidadConstrucciones = 4, viveEnRegion = new llanura(), inteligencia = 12)
const constructorCuatro = new Constructor(edad = 45, monedas = 180, cantidadConstrucciones = 7, viveEnRegion = new desierto(), inteligencia = 18)

const productorUno = new Productor(edad = 50, monedas = 200, viveEnPlaneta = tierra)
const productorDos = new Productor(edad = 55, monedas = 250, viveEnPlaneta = marte)

/* constructorUno.trabajar(10, tierra)
constructorDos.trabajar(15, marte)
constructorTres.trabajar(12, tierra)
constructorCuatro.trabajar(18, marte)

productorUno.realizar(cultivo, 10)
productorDos.realizar(cultivo, 15) 

tierra.agregarConstruccion(new Muralla(longitud = 20))
marte.agregarConstruccion(new Museo(superficie = 25, indiceDeImportancia = 2)) */
////////////////////////////////////////////////////////////////////////
object cultivo{} //para q reconozca la tecnica