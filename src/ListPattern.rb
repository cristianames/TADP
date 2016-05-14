class ListPattern
  include ComposablePattern
  attr_accessor :list, :match_size

  def call(a_list, &block)
    if type(Array).call(a_list) || !(self.list.length > a_list.length)
      same_size = true
      if match_size
        same_size = self.list.length == a_list.length
      end
      same_size & self.list.zip(a_list).all? do |pattern, value|
        if !block
          pattern.call(value)
        else
          pattern.call(value, &block)
        end
      end
    else
      false
    end
  end
end