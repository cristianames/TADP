class Matcher
  def self.variable(*args)
    Matcher_de_variable.new(*args)
  end
  def self.val(p)
    Matcher_valor.new(p)
  end
  def self.type(p)
    Matcher_tipo.new(p)
  end
  def self.list(p, *matches_s)
    if !matches_s
    Matcher_listas.new(p, true)
    else
      Matcher_listas.new(p, false)
    end
  end
  def self.duck(*p)
    Matcher_metodos.new(*p)
  end
  def self.and(*matchers)
    Matcher_combinado_and.new(*matchers)
  end
  def self.or(*matchers)
    Matcher_combinado_or.new(*matchers)
  end
  def self.not(matcher)
    Matcher_combinado_not.new(matcher)
  end
end

class Matcher_de_variable
  attr_accessor :patrones
  def initialize(*p)
    self.patrones= p
  end
  def match?(*args)
    true
  end
end
class Matcher_valor
  attr_accessor :patron
  def initialize(p)
    self.patron= p
  end
  def match?(parameter)
    patron == parameter
  end
end

class Matcher_tipo
  attr_accessor :patron
  def initialize(p)
    self.patron= p
  end
  def match?(parameter)
    parameter.instance_of? patron
  end
end

class Matcher_listas
  attr_accessor :patron, :siz
  def initialize(p, siz)
    self.patron= p
    self.siz = siz
  end
def match?(parameter)

    parameter.size == patron.size unless siz
      (patron.take(parameter.size) - parameter).size == 0
end

end

class Matcher_metodos
  attr_accessor :patron
  def initialize(*p)
    self.patron= p
  end
def match?(object)
  begin
      patron.all? { |m| object.send(m)}
    rescue NoMethodError
      false
  end
end
end

class Matcher_combinado_and
  attr_accessor :matchers
  def initialize(*p)
    self.matchers= p
  end
  def match? (arg)
    matchers.all? { |matcher| matcher.match? arg}
  end
end
class Matcher_combinado_or
  attr_accessor :matchers
  def initialize(*p)
    self.matchers= p
  end
  def match?(arg)
    matchers.any? { |matcher| matcher.match? arg}
  end
end
class Matcher_combinado_not
  attr_accessor :matcher
  def initialize(p)
    self.matcher= p
  end
  def match?(arg)
    ! (matcher.match? arg)
  end
end





