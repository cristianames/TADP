class ListApplicator

  def applicate(parameters, comparation_values)
    if parameters.length < 2
      # raise error
      return false
    end
    list = parameters[0]
    match_size = parameters[1]
    if list.length < comparation_values.length
      #   raise error
      return false
    end
    if match_size and list.length != comparation_values.length
      # raise error
      return false
    end


      for i = 0 in i < list.length
        if !val(list[i]).call(comparation_values[i])
          return false
        end
      end
    return true
  end

end