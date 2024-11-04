class Minion{
    var rol

    method arreglarMaquina()
}

class Biclope inherits Minion{
    var property staminaMaxima = 10
}

class soldado{
    var arma
    var danioCausado

    method defender() {
      danioCausado = danioCausado + 2
    }
}

class obrero{
    const herramientas = new List()
}

class mucama{
    method defender() {
      self.error("La mucama se nego a defender")
    }
}