require 'rspec'
require '../src/PatternMatching.rb'

include PatternMatching

class Dragon
  def fly
    'Do some fly'
  end
end

describe :duck_typing do

  before :all do
    @psyduck = Object.new
    @psyduck.send(:define_singleton_method, :cuack) do
      'psy..duck?'
    end
    @psyduck.send(:define_singleton_method, :fly) do

    end
    @a_dragon = Dragon.new
  end

  describe :contain_methods do

    it 'should be true if contains all methods' do
      expect(duck(:cuack, :fly).call(@psyduck)).to eq true
    end
    it 'should be false if not contains all methods' do
      expect(duck(:cuack, :fly).call(@a_dragon)).to eq false
    end
    it 'should be true if contains one method' do
      expect(duck(:cuack).call(@psyduck)).to eq true
    end

  end

end