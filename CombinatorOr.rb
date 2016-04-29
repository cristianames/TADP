require_relative 'MatcherCombinator'

class CombinatorOr < MatcherCombinator

  def call un_objeto
    self.matchers.any? do |matcher| matcher.call un_objeto end
  end

end