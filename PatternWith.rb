class PatternWith
  attr_accessor :matchers, :block
  def initialize matchers, block
    self.matchers = matchers
    self.block = block
  end

  def match un_objeto
    combinator = CombinatorAnd.new self.matchers
    (p 'Desde el with no pasan por el combinator'; return false) unless combinator.call un_objeto

    properties = { :a => 'dummy'}
    # self.matchers.each do |matcher|
    #
    #   properties = properties.merge matcher.get_bindeos un_objeto
    # end

    properties = properties.merge combinator.get_bindeos un_objeto

    return Struct.new(*properties.keys)
               .new(*properties.values)
               .instance_eval &self.block
  end
end