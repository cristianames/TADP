class Symbol
  def call(un_valor)
    return true
  end

  def get_bindeos un_objeto
    { self => un_objeto }
  end
end