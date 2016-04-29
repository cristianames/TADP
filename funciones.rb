def val(un_objeto)
  MatcherValor.new un_objeto
end

def type(un_tipo)
  MatcherTipo.new un_tipo
end

def list(values, match_size=true)
  MatcherLista.new values, match_size
end
def duck (*metodos)
  MatcherDuckTyping.new metodos
end

def with *matchers, &block
  PatternWith.new matchers, block
end

def otherwise &bloque
  PatternOtherwise.new bloque
end

