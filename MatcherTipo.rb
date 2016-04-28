class MatcherTipo < MatcherGeneral
  attr_accessor :tipo

  def initialize(unTipo)
    self.tipo = unTipo
  end

  def call(unObjeto)
    unObjeto.class.ancestors.include? self.tipo
  end
end