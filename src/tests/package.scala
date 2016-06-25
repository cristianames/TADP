import Personaje

package object tests {
  val guerrero = new Personaje(Guerrero, Stats(50, 10, 10, 10), List(arcoViejo, cascoVikingo))
  
  val ladron = new Personaje(Ladron, Stats(50, 10, 10, 10), List(arcoViejo, cascoVikingo))
  
  val equipo1 = new Equipo(List(guerrero), 3, "Pancho")
  
  val equipo2 = new Equipo(List(ladron), 50, "Pancho2")
  
  val equipo3 = new Equipo(List(ladron, guerrero), 100, "Pancho3")
  
  val taberna = new Taberna(List(misionPrueba, misionPoco))
  
  
  guerrero.getFuerza() == 27
  
  guerrero.getHP() == 70
  
  ladron.getFuerza() == 12
  
  ladron.getHP() == 55
  
  !guerrero.equipar(escudoAntiRobo).items.contains(arcoViejo)
  
  equipo1.elegirMision(taberna, (e1, e2) => e1.pozo > e2.pozo) == misionPrueba
}