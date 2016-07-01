import scala.util.Try

// Semi-monada que maneja los resultados de realizar tareas y misiones
// Cuando se falla de realizar una mision, contiene la tarea que no se pudo realizar
trait ResultadoMision {
  def map(f: Equipo => Equipo): ResultadoMision
  def flatMap(f: Equipo => ResultadoMision): ResultadoMision
}

case class Victorioso(val equipo: Equipo) extends ResultadoMision {
  def map(f: Equipo => Equipo) = this.copy(f(equipo))
  def flatMap(f: Equipo => ResultadoMision) = f(equipo)
}

case class Derrotado(val equipo: Equipo, val tareaNoCumplida: Tarea) extends ResultadoMision {
  def map(f: Equipo => Equipo) = this
  def flatMap(f: Equipo => ResultadoMision) = this
}

class Equipo(val miembros: List[Personaje], val pozo: Double, val nombre: String) {

  def getLider(): Option[Personaje] = {
    if (miembros.isEmpty) {
      return None
    }
    val lider = miembros.maxBy { heroe => heroe.statPrincipal() }
    if (miembros.filter { heroe => heroe.statPrincipal() == lider.statPrincipal() }.size > 1) {
      None
    } else {
      Some(lider)
    }
  }

  def mejorHeroeSegun(criterio: Personaje => Int): Try[Personaje] = {
    Try(miembros.maxBy(criterio(_)))
  }

  def realizarMision(mision: Mision): ResultadoMision = {
    mision.tareas.foldRight[ResultadoMision](Victorioso(this)) {
      (tarea, equipo) =>
        equipo.flatMap { e =>
          val heroeApto = e.miembros.maxBy { tarea.facilidadPara(_, e) }
          tarea.realizadaPor(heroeApto, e)
        }
    }.map { mision.recompensarEquipo(_) }
  }

  def elegirMision(taberna: Taberna, criterio: (Equipo, Equipo) => Boolean): Try[Mision] = {
    Try(taberna.misiones.sortWith { (mision1, mision2) =>
      val equipo1 = realizarMision(mision1)
      val equipo2 = realizarMision(mision2)
      (equipo1, equipo2) match {
        case (Derrotado(_, _), _)             => false
        case (_, Derrotado(_, _))             => true
        case (Victorioso(e1), Victorioso(e2)) => criterio(e1, e2)
      }

    }.head)
  }

  def entrenar(taberna: Taberna): ResultadoMision = {
    taberna.misiones.foldRight[ResultadoMision](Victorioso(this)) { (mision, equipo) =>
      equipo.flatMap(_.realizarMision(mision))
    }
  }

  def obtenerUnItem(item: Equipable): Equipo = {
    val mejorHeroe = miembros.filter { heroe => item.puedeUsarlo(heroe) }
      .maxBy { heroe => heroe.diferenciaEnStatPrincipal(item) }
    if (mejorHeroe.diferenciaEnStatPrincipal(item) <= 0) {
      new Equipo(miembros, pozo + item.valor, nombre)
    } else {
      new Equipo(mejorHeroe.equipar(item) :: miembros.filter { x => x != mejorHeroe }, pozo, nombre)
    }
  }

  def obtenerMiembro(heroe: Personaje): Equipo = {
    new Equipo(heroe :: miembros, pozo, nombre)
  }

  def reemplazarMiembro(heroeLlega: Personaje, heroeSeVa: Personaje): Equipo = {
    new Equipo(heroeLlega :: miembros.filter(_ != heroeSeVa), pozo, nombre)
  }

}