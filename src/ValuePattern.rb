class ValuePattern
  include ComposablePattern
  attr_accessor :value

  def call(a_value)
    self.value === a_value
  end
end