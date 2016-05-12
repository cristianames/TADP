require 'rspec'
require '../src/Server.rb'

describe :variable_val do

  before :all do
    an_array = [1, 2, 3, 4, 5]
  end

  describe :with_one_argument do

    it 'should be Applicable' do
      expect(type(Integer).class).to eq(Applicable)
    end
    it 'should be false if different type of content' do
      expect(type(Symbol).call "Trust me, I'm a Symbol..").to eq false
    end
    it 'should be true if same type' do
      expect(type(Symbol).call :a_real_symbol).to eq true
    end
    it 'should be true when is part of same hierarchy' do
      expect(type(Integer).call 5).to eq true
    end

  end

  describe :with_two_arguments do

    it 'should be Applicable' do
      expect(type(Integer).class).to eq(Applicable)
    end
    it 'should be false if different type of content' do
      expect(type(Symbol).call "Trust me, I'm a Symbol..").to eq false
    end
    it 'should be true if same type' do
      expect(type(Symbol).call :a_real_symbol).to eq true
    end
    it 'should be true when is part of same hierarchy' do
      expect(type(Integer).call 5).to eq true
    end

  end

end
