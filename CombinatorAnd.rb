require_relative 'MatcherCombinator'

class CombinatorAnd < MatcherCombinator

  def call un_objeto
    self.matchers.all? do |matcher|
      resultado = matcher.call un_objeto
      # p resultado.to_s + matcher.to_s
      return resultado
    end
  end

end