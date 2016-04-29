require_relative 'MatcherGeneral'

class Symbol

  include MatcherGeneral

  def call(un_valor)
    return true
  end

  def get_bindeos un_objeto
    { self => un_objeto }
  end
end

