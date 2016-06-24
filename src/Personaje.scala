
case class Stats(val hp: Int, val fuerza: Int, val inteligencia: Int, val velocidad: Int);

class Personaje(val trabajo: Trabajo, val stats: Stats, val items: List[Equipable]) {

  def equipar(item: Equipable) = {
    val nuevoInventario = item :: items.filter { equipado => !item.reemplazaA(equipado) }
    new Personaje(trabajo, stats, nuevoInventario)
  }

  def calcularStats(): Stats = {
    val sinLimite = (trabajo :: items).foldRight(stats) {
      (modificador, estat) => modificador.modificarStats(estat, this)
    }
    sinLimite.copy(sinLimite.hp.max(1),
        sinLimite.fuerza.max(1),
        sinLimite.inteligencia.max(1),
        sinLimite.velocidad.max(1))
  }
  
  def diferenciaEnStatPrincipal(item: Equipable): Int = {
    val heroeEquipado = this.equipar(item)
    heroeEquipado.statPrincipal() - this.statPrincipal()
  }
  
  def statPrincipal() = {
    trabajo.calcularStatPrincipal(this)
  }

  def setFuerza(fuerza: Int) = {
    new Personaje(trabajo, stats.copy(stats.hp, fuerza, stats.inteligencia, stats.velocidad), items)
  }

  def setHP(hp: Int) = {
    new Personaje(trabajo, stats.copy(hp, stats.fuerza, stats.inteligencia, stats.velocidad), items)
  }

  def setVelocidad(velocidad: Int) = {
    new Personaje(trabajo, stats.copy(stats.hp, stats.fuerza, stats.inteligencia, velocidad), items)
  }

  def setInteligencia(inteligencia: Int) = {
    new Personaje(trabajo, stats.copy(stats.hp, stats.fuerza, inteligencia, stats.velocidad), items)
  }

  def hpBase() = {
    stats.hp
  }

  def fuerzaBase() = {
    stats.fuerza
  }

  def velocidadBase() = {
    stats.velocidad
  }

  def inteligenciaBase() = {
    stats.inteligencia
  }

  def getFuerza() = {
    this.calcularStats.fuerza
  }

  def getHP() = {
    this.calcularStats.hp
  }

  def getVelocidad() = {
    this.calcularStats.velocidad
  }

  def getInteligencia() = {
    this.calcularStats.inteligencia
  }
}