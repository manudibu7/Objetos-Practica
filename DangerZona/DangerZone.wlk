class Empleado{
	var salud
	var habilidades = new List()
	var esJefe 

	method saludCritica()

	method incapacitado(){
		return salud<self.saludCritica()
	}

	method puedeUsar(habilidad){
		return self.incapacitado().negate() and habilidades.contains(habilidad)
	}

	method cumplirMision(mision){
		if(!self.puedeCumplirMision(mision)){
			self.error("El empleado no cuenta con las habilidades requeridas para cumplir la mision")
		}
		salud = salud - mision.peligrosidad()
	}

	method puedeCumplirMision(mision){
		return mision.habilidadesRequeridas().forEach{habilidadRequerida => habilidades.contains(habilidadRequerida)}
	}


}

class Espia inherits Empleado{
	override method saludCritica() = 15

	override method cumplirMision(mision) {
	  	super(mision) 
		mision.habilidadesRequeridas().forEach{
			habilidadRequerida => 
			if(!habilidades.contains(habilidadRequerida)){
				habilidades.add(habilidadRequerida)
			}
		}
	}
}

class Oficinista inherits Empleado{
	var cantidadEstrellas

	override method saludCritica(){
		return 40 - 5*cantidadEstrellas
	}

	override method cumplirMision(mision){
		super(mision)
		cantidadEstrellas = cantidadEstrellas + 1
		//para q se convierta en espia tendria que haber usado composicion
	}

	
}

class Mision{
	const habilidadesRequeridas = new List()
	const peligrosidad

	method peligrosidad() = peligrosidad
	method habilidadesRequeridas() = habilidadesRequeridas
}