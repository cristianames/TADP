

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

  def mejorHeroeSegun(criterio: Personaje => Int): Option[Personaje] = {
    if (miembros.isEmpty) {
      return None
    }
    Some(miembros.maxBy(criterio(_)))
  }

  def realizarMision(mision: Mision): Equipo = {
    // Hacer cada tarea, devolver equipo cambiado
    this
  }

  def elegirMision(taberna: Taberna, criterio: (Equipo, Equipo) => Boolean): Option[Mision] = {
    if (taberna.misiones.isEmpty) {
      return None
    }
    Some(taberna.misiones.sortWith { (mision1, mision2) =>
      val equipo1 = this.realizarMision(mision1)
      val equipo2 = this.realizarMision(mision2)
      criterio(equipo1, equipo2)
    }.head)
  }

  def entrenar(taberna: Taberna): Equipo = {
    // Hacer todas las misiones
    this
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