class Comp_pattern
  include ComposablePattern
  attr_accessor :patterns, :list_method

  def call(a_value, &block)
    patterns.send(self.list_method) do |pattern|
      pattern.call(a_value) do block.call end
    end
  end
end