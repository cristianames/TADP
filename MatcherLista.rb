class MatcherLista
  include MatcherGeneral

  attr_accessor :values, :match_size

  def initialize values, match_size
    self.values = values
    self.match_size = match_size
  end

  def call una_lista

    (#p 'no es array';
        return false) if !una_lista.kind_of? Array
    (#p 'no coincide match_size';
        return false) if (match_size && values.size != una_lista.size)
    (#p 'la lista es muy chica';
        return false) if (self.values.size > una_lista.size)

    todos_cumplen = self.values.zip(una_lista).all? do |matcher_o_valor, objeto|
      # [1, 2, 3, 4].zip [1, 2, 3, 4] => [ [1, 1], [1, 1], [1, 1], [1, 1] ]
      return matcher_o_valor.call(objeto) if (matcher_o_valor.kind_of? MatcherGeneral)
      return val(matcher_o_valor).call objeto
    end

    p 'Todos cumplen? =>' + todos_cumplen
    return todos_cumplen

  end

  def get_bindeos un_objeto
    bindeos = {}

    return bindeos if !call un_objeto

    self.values.zip(un_objeto).each do |matcher, objeto|
      bindeos = bindeos.merge matcher.get_bindeos objeto
    end

    return bindeos
  end
end