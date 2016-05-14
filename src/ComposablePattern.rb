module ComposablePattern

  def and(*other_patterns)
    pattern = AndPattern.new
    pattern.patterns = other_patterns
    pattern.patterns << self
    pattern
  end

  def or(*other_patterns)
    pattern = OrPattern.new
    pattern.patterns = other_patterns
    pattern.patterns << self
    pattern
  end

  def not
    pattern = NotPattern.new
    pattern.pattern = self
    pattern
  end
end
