class ValueApplicator

  def applicate(value, comparationValues)
    if comparationValues.length > 1
      return false
    end
    return value == comparationValues[0]
  end

end