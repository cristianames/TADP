require 'rspec'
require '../src/PatternMatching.rb'

include PatternMatching

describe :variable_matcher do

  describe :with_no_arguments do

    it 'should say true' do
      expect(:some_symbol.call('hola')).to eq(true)
    end

  end

  describe :with_one_argument do

    it 'should say true' do
      expect(:some_symbol.call(5)).to eq(true)
    end

  end

  describe :with_many_arguments do

    it 'should say true' do
      expect(:some_symbol.call('Hello', 12, Object.new)).to eq(true)
    end
  end

end