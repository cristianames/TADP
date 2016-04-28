class MatcherGeneral
  def and *matchers
    CombinatorAnd.new matchers.push self
  end
  def or *matchers
    CombinatorOr.new matchers.push self
  end
  def not
    MatcherNot.new self
  end
  def get_bindeos un_objeto
    {}
  end
end