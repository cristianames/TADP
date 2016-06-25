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

  def realizarMision(mision: Mision): Option[Equipo] = {
    mision.tareas.foldRight[Option[Equipo]](Some(this)){
      (tarea, equipo) => equipo.flatMap { e =>
        val heroeApto = e.miembros.maxBy { tarea.facilidadPara(_, e) }
        if (tarea.facilidadPara(heroeApto, e) <= 0) {
          None
        } else {
          Some(tarea.realizadaPor(heroeApto, e))
        }
      }
    }.map { mision.recompensarEquipo(_) }
  }

  def elegirMision(taberna: Taberna, criterio: (Equipo, Equipo) => Boolean): Option[Mision] = {
    if (taberna.misiones.isEmpty) {
      return None
    }
    Some(taberna.misiones.sortWith { (mision1, mision2) =>
      val equipo1 = realizarMision(mision1)
      val equipo2 = realizarMision(mision2)
      equipo1 match {
        case None => false
        case Some(e1) => equipo2 match {
          case None     => true
          case Some(e2) => criterio(e1, e2)
        }
      }

    }.head)
  }

  def entrenar(taberna: Taberna): Option[Equipo] = {
    taberna.misiones.foldRight[Option[Equipo]](Some(this)) { (mision, equipo) =>
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