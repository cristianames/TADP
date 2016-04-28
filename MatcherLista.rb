class MatcherLista < MatcherGeneral
  attr_accessor :values, :match_size

  def initialize values, match_size
    self.values = values
    self.match_size = match_size
  end

  def call unaLista
    if (match_size && values.size != unaLista.size)
      return false
    end

    if (self.values.size > unaLista.size)
      return false;
    end

    self.values.zip(unaLista).all? do |elem1, elem2|
      # [1, 2, 3, 4].zip [1, 2, 3, 4] => [ [1, 1], [1, 1], [1, 1], [1, 1] ]

      if type(Symbol).call(elem1)
        return true;
      end

      return val(elem1) .call elem2
    end

  end
end