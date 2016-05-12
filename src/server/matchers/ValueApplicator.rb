class ValueApplicator

  def applicate(parameters, comparation_value)
    value = parameters[0]
    if value.class == Symbol
      return value.call(comparation_value)
    end
    value == comparation_value
  end

end