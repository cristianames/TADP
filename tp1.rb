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

class PatternWith
  attr_accessor :matchers, :block, :estructura
  def initialize matchers, block
    self.matchers = matchers
    self.block = block
    simbolos = matchers.select do | matcher |
      type(Symbol).call matcher
    end
    if ( simbolos.size == 0)
      self.estructura = Object.new
    end else
    self.estructura= Struct.new(*simbolos).new
  end

  def match un_objeto
    if (CombinatorAnd.new matchers) .call un_objeto
      return self.estructura.instance_eval &self.block
    end
  end
end