class MatcherValor

  include MatcherGeneral

  attr_accessor :valor

  def initialize(valor)
    self.valor= valor
  end

  def call(arg)
    self.valor === arg
  end
end