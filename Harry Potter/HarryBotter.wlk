
class Bot{
    var cargaElectrica
    var property aceiteLimpio
    var property activo
}

class Estudiante inherits Bot{
    var casa
    const hechizos = new List()

    method asignarCasa(casaAsignada){
        casa = casaAsignada
        casaAsignada.incorporarEstudiante(self)
    }

    method conoceHechizo(hechizo) = hechizos.contains(hechizo)
}

class Casa{
    var estudiantes = new List()

    method esPeligroso()

    method incorporarEstudiante(estudiante){
        estudiantes.add(estudiante)
    }
}

class Gryffindor inherits Casa{
    override method esPeligroso()= false
}
class Slytherin inherits Casa{
    override method esPeligroso()= true
}

class Ravenclaw inherits Casa{
    override method esPeligroso(){
        const aceitesLimpios = estudiantes.filter{estudiante=>estudiante.aceiteLimpio()}
        const aceitesSucios = estudiantes.filter{estudiante=>!estudiante.aceiteLimpio()}
        aceitesLimpios < aceitesSucios
    }
}

class Hufflepuff inherits Casa{
    override method esPeligroso(){
        const aceitesLimpios = estudiantes.filter{estudiante=>estudiante.aceiteLimpio()}
        const aceitesSucios = estudiantes.filter{estudiante=>!estudiante.aceiteLimpio()}
        aceitesLimpios < aceitesSucios
    }
}