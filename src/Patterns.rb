require 'Matcher.rb'
class Pattern
  def self.with(p)
    Pattern_with.new(p)
  end
  def self.otherwise
    Pattern_otherwise.new
  end
end

class Pattern_with
  attr_accessor :matchers
  def initialize(*m)
    self.matchers= m
  end
  def matches?(&block)
    if matchers.all? block.call
  end
  end
end

class Pattern_otherwise
  def matches?(&block)
    block.call
  end
end