
trait Posicion;
case object ManoDerecha extends Posicion;
case object ManoIzquierda extends Posicion;
case object DosManos extends Posicion;
case object Cabeza extends Posicion;
case object Cuerpo extends Posicion;
case object NoOcupa extends Posicion;

trait Equipable extends Modificador {
  var valor = 100
  var posicion: Posicion = NoOcupa;

  def puedeUsarlo(heroe: Personaje): Boolean = {
    true
  }

  def reemplazaA(item: Equipable): Boolean = {
    item.posicion == posicion && posicion != NoOcupa
  }

}

object cascoVikingo extends Equipable {
  posicion = Cabeza;

  override def puedeUsarlo(heroe: Personaje): Boolean = {
    heroe.fuerzaBase() > 30
  }

  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp + 10, stats.fuerza, stats.inteligencia, stats.velocidad)
  }

}

object vinchaBufaloAgua extends Equipable {
  posicion = Cabeza
  override def puedeUsarlo(heroe: Personaje): Boolean = {
    heroe.trabajo == Ninguno
  }

  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    if (stats.inteligencia < stats.fuerza) {
      stats.copy(stats.hp, stats.fuerza, stats.inteligencia + 30, stats.velocidad)
    } else {
      stats.copy(stats.hp + 10, stats.fuerza + 10, stats.inteligencia, stats.velocidad + 10)
    }
  }
}

object TalismanDeDedicacion extends Equipable {
  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    val dedicacion = heroe.trabajo.calcularStatPrincipal(heroe) / 10
    stats.copy(stats.hp + dedicacion,
        stats.fuerza + dedicacion,
        stats.inteligencia + dedicacion,
        stats.velocidad + dedicacion)
  }
}