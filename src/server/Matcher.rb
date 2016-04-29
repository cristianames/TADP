# require './src/server/Server.rb'

require_relative 'matchers/Applicable'
require_relative 'matchers/ValueApplicator'


class Matcher
  def self.start
    variable_init
    value_init
  end

  def self.variable_init
    Symbol.send(:define_method, :call) do
    |*args|
      true
    end
  end

  def self.value_init
    Object.send(:define_method, :val) do
      |value|
      return Applicable.new(value, ValueApplicator.new)
    end
  end
end