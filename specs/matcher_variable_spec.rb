require 'rspec'
require '../src/PatternMatching.rb'

include PatternMatching

describe :variable_matcher do

  describe :with_one_argument do

    it 'should say true' do
      expect(:some_symbol.call(5)).to eq true
    end

  end

end