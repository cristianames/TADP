require_relative 'set_ups'
require_relative 'funciones'
require_relative 'MatcherGeneral'
require_relative 'MatcherValor'
require_relative 'MatcherTipo'
require_relative 'MatcherLista'
require_relative 'MatcherDuckTyping'
require_relative 'CombinatorAnd'
require_relative 'CombinatorOr'
require_relative 'MatcherNot'
require_relative 'PatternWith'
require_relative 'MatcherCombinator'
require_relative 'PatternOtherwise'

def matches? (un_objeto, &patterns)
  PatternMatching.new un_objeto
end
