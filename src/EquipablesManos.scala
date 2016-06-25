

trait EquipableUnaMano extends Equipable {

  override def reemplazaA(item: Equipable): Boolean = {
    super.reemplazaA(item) || item.posicion == DosManos
  }

}

trait EquipableDosManos extends Equipable {

  override def reemplazaA(item: Equipable): Boolean = {
    super.reemplazaA(item) || item.posicion == ManoDerecha || item.posicion == ManoIzquierda
  }

}

object arcoViejo extends EquipableDosManos {
  posicion = DosManos
  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp, stats.fuerza + 2, stats.inteligencia, stats.velocidad)
  }
}

object escudoAntiRobo extends EquipableUnaMano {
  posicion = ManoIzquierda
  
  override def puedeUsarlo(heroe: Personaje): Boolean = {
    heroe.trabajo match {
      case Ladron => false
      case _ => heroe.getFuerza() < 20
    }
  }
  
  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp + 20, stats.fuerza, stats.inteligencia, stats.velocidad)
  }
}

object palitoMagico extends EquipableUnaMano {
  posicion = ManoDerecha
  
  override def puedeUsarlo(heroe: Personaje): Boolean = {
    heroe.trabajo match {
      case Mago => true
      case Ladron => heroe.getInteligencia() > 30
      case _ => false
    }
  }
  
  def modificarStats(stats: Stats, heroe: Personaje): Stats = {
    stats.copy(stats.hp, stats.fuerza + 2, stats.inteligencia, stats.velocidad)
  }
}