class TypeApplicator

  def applicate(value, comparationValues)
    if comparationValues.length > 1
      return false
    end
    return comparationValues[0].class.ancestors.include? value
  end


end