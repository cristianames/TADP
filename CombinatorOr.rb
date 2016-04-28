class CombinatorOr < MatcherGeneral
  attr_accessor :matchers
  def initialize matchers
    self.matchers=matchers
  end

  def call un_objeto
    self.matchers.any? do |matcher| matcher.call un_objeto end
  end
end