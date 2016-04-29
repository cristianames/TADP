class PatternOtherwise
  attr_accessor :bloque

  def initialize bloque
    self.bloque =bloque
  end

  def match un_objeto
    instance_eval &self.bloque
  end
end