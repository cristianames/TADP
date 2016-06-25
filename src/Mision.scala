

class Taberna(val misiones: List[Mision])

trait Mision {
  val tareas: List[Tarea]
  
  def recompensarEquipo(equipo: Equipo): Equipo;
  
}

trait Tarea {
  
  def facilidadPara(heroe: Personaje, equipo: Equipo): Int
  def realizadaPor(heroe: Personaje, equipo: Equipo): Equipo

}

trait TareaPremioGanarOro extends {
  var oro: Int = 50
  
  def setOro(oro: Int) {
    this.oro = oro
  }
  
  def realizadaPor(heroe: Personaje, equipo: Equipo): Equipo = {
    new Equipo(equipo.miembros, equipo.pozo + oro, equipo.nombre)
  }
}

object PelearContraMonstruo extends TareaPremioGanarOro {
  
  def facilidadPara(heroe: Personaje, equipo: Equipo): Int = {
    val liderGuerrero = equipo.getLider().map { h => h.trabajo == Guerrero }.getOrElse(false)
    if (liderGuerrero) {
      20
    } else {
      10
    }
  }
  
}

object ForzarPuerta extends TareaPremioGanarOro {
  def facilidadPara(heroe: Personaje, equipo: Equipo): Int = {
    equipo.miembros.count { p => p.trabajo == Ladron } + heroe.getInteligencia()
  }
}