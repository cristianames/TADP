class MatcherDuckTyping

  include MatcherGeneral

  attr_accessor :metodos
  def initialize metodos
    self.metodos =metodos
  end
  def call unObjeto
    self.metodos.all? do | metodo |
      unObjeto.public_methods.include? metodo
    end
  end
end