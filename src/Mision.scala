

class Taberna(val misiones: List[Mision])

trait Mision {
  var tareas: List[Tarea]
  
  def recompensarEquipo(equipo: Equipo): Equipo;
  
}

object misionPrueba extends Mision {
  tareas = List[Tarea](pelearContraMonstruo, forzarPuerta)
}

object misionPoco extends Mision {
  tareas = List[Tarea](pelearContraMonstruo)
}

trait Tarea {
  
  def facilidadPara(heroe: Personaje, equipo: Equipo): Int
  def realizadaPor(heroe: Personaje, equipo: Equipo): Equipo

}

trait TareaPremioSubirFuerza extends Tarea {
  
  def realizadaPor(heroe: Personaje, equipo: Equipo): Equipo = {
    val heroeNuevo = heroe.setFuerza(heroe.fuerzaBase() + 10)
    equipo.reemplazarMiembro(heroeNuevo, heroe)
  }
  
}

trait TareaPremioGanarOro extends Tarea {
  var oro: Int = 50
  
  def setOro(oro: Int) {
    this.oro = oro
  }
  
  def realizadaPor(heroe: Personaje, equipo: Equipo): Equipo = {
    new Equipo(equipo.miembros, equipo.pozo + oro, equipo.nombre)
  }
}

object pelearContraMonstruo extends TareaPremioGanarOro {
  
  def facilidadPara(heroe: Personaje, equipo: Equipo): Int = {
    val liderGuerrero = equipo.getLider().map { h => h.trabajo == Guerrero }.getOrElse(false)
    if (liderGuerrero) {
      20
    } else {
      10
    }
  }
  
}

object forzarPuerta extends TareaPremioGanarOro {
  def facilidadPara(heroe: Personaje, equipo: Equipo): Int = {
    equipo.miembros.count { p => p.trabajo == Ladron } + heroe.getInteligencia()
  }
}