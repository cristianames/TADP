class MatcherLista < MatcherGeneral
  attr_accessor :values, :match_size

  def initialize values, match_size
    self.values = values
    self.match_size = match_size
  end

  def call una_lista

    return false if !una_lista.kind_of? Array
    return false if (match_size && values.size != una_lista.size)
    return false if (self.values.size > una_lista.size)

    self.values.zip(una_lista).all? do |elem1, elem2|
      # [1, 2, 3, 4].zip [1, 2, 3, 4] => [ [1, 1], [1, 1], [1, 1], [1, 1] ]

      if type(Symbol).call(elem1)
        return true;
      end

      return val(elem1) .call elem2
    end

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