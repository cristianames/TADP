class MatchException < RuntimeError
  attr_accessor :answer

  def initialize(answer=nil)
    self.answer = answer
  end
end

class NoMatchError < RuntimeError
end