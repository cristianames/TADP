class MatcherCombinator

  include MatcherGeneral

  attr_accessor :matchers

  def initialize matchers
    self.matchers=matchers
  end

  def get_bindeos un_objeto
    bindeos = {}
    self.matchers.each do |matcher|
      #Cada matcher devolverá una lista de pares clave valor que seran simbolo => valor_bindeado
      bindeos = bindeos.merge matcher.get_bindeos un_objeto
    end

    return bindeos
  end

end