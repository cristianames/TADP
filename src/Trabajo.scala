

trait Trabajo extends Modificador {

  def calcularStatPrincipal(heroe: Personaje): Int;

}

case object Mago extends Trabajo {

  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp, stats.fuerza - 20, stats.inteligencia + 20, stats.velocidad)
  }
  def calcularStatPrincipal(heroe: Personaje): Int = {
    heroe.getInteligencia()
  }

}

case object Guerrero extends Trabajo {

  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp + 10, stats.fuerza + 15, stats.inteligencia - 10, stats.velocidad)
  }
  def calcularStatPrincipal(heroe: Personaje): Int = {
    heroe.getFuerza()
  }

}

case object Ladron extends Trabajo {

  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp - 5, stats.fuerza, stats.inteligencia, stats.velocidad + 10)
  }
  def calcularStatPrincipal(heroe: Personaje): Int = {
    heroe.getVelocidad()
  }

}

case object Ninguno extends Trabajo {

  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats
  }
  def calcularStatPrincipal(heroe: Personaje): Int = {
    0
  }

}