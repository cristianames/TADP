class TypeApplicator

  def applicate(parameters, comparation_value)
    value = parameters[0]
    # value.is_a? comparation_value
    comparation_value.class.ancestors.include? value
  end

end