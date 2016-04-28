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
  attr_accessor :matchers, :block
  def initialize matchers, block
    self.matchers = matchers
    self.block = block
  end

  def match un_objeto

    return false unless (CombinatorAnd.new matchers).call un_objeto
    properties = { :a => 'dummy'}
    self.matchers.each do |matcher|
      #Cada matcher devolverá una lista de pares clave valor que seran simbolo => valor_bindeado
      properties = properties.merge matcher.get_bindeos un_objeto
    end
    return Struct.new(*properties.keys)
               .new(*properties.values)
               .instance_eval &self.block
  end
end