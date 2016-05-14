class TypePattern
  include ComposablePattern
  attr_accessor :type

  def call(a_value)
    a_value.is_a? self.type
  end
end