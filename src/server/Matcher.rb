class Matcher
  def self.start
    variable_init
    value_init
    type_init
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
      Applicable.new(value, ValueApplicator.new)
    end
  end

  def self.type_init
    Object.send(:define_method, :type) do
    |value|
      Applicable.new(value, TypeApplicator.new)
    end
  end

end