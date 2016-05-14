class PatternContext
  attr_accessor :pattern_argument

  # Metodo de contexto.
  def define_variable(sym, a_value)
    self.define_singleton_method(sym) do
      a_value
    end
  end
end