class Symbol
  attr_accessor :valor
  def call(un_valor)
    self.valor=un_valor
    return true
  end
end