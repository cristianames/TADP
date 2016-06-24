

class Taberna(val misiones: List[Mision])

trait Mision {
  val tareas: List[Tarea]
  
  def recompensarEquipo(equipo: Equipo): Equipo;
  
}