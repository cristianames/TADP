class MatcherNot < MatcherGeneral
  attr_accessor :matcher_base
  def initialize matcher_base
    self.matcher_base= matcher_base
  end
  def call un_objeto
    !self.matcher_base.call un_objeto
  end
end