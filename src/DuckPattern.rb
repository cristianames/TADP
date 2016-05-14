class DuckPattern
  include ComposablePattern
  attr_accessor :duck_methods

  def call(obj)
    self.duck_methods.all? do |method|
      obj.methods.include? method
    end
  end
end