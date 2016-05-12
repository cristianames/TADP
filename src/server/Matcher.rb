class Matcher
  def self.start
    variable_init
    value_init
    type_init
    list_init
  end

  def self.variable_init
    Symbol.send(:define_method, :call) do
    |*args|
      true
    end
  end

  def self.value_init
    Object.send :define_method, :val do
      |value|
      Applicable.new ValueApplicator.new, value
    end
  end

  def self.type_init
    Object.send :define_method, :type do
    |value|
      Applicable.new TypeApplicator.new, value
    end
  end

  def self.list_init
    Object.send :define_method, :list do
      |value, match_size|
      Applicable.new ListApplicator.new, value, match_size
    end
  end

end