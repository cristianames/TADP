class NotPattern
  include ComposablePattern
  attr_accessor :pattern

  def call(a_value, &block)
    !(pattern.call(a_value) &block)
  end
end