require 'rspec'
require '../src/PatternMatching.rb'
require '../lib/age.rb'

include PatternMatching

class Dragon
  def fly
    'Do some fly'
  end
end

describe :combinators do

  before :all do
    @una_muralla = Muralla.new
    @un_guerrero = Guerrero.new
  end

  describe :and do

    it 'should be false if not all asserts' do
      expect(type(Defensor).and(type(Atacante)).call(@una_muralla)).to eq false
    end
    it 'should be true if all asserts 1' do
      expect(type(Defensor).and(type(Atacante)).call(@un_guerrero)).to eq true
    end
    it 'should be true if all asserts 2' do
      expect(duck(:+).and(type(Fixnum), val(5)).call(5)).to eq true
    end

  end

  describe :or do

    it 'should be true if assert at least one' do
      expect(type(Defensor).or(type(Atacante)).call(@una_muralla)).to eq true
    end
    it 'should be false if all goes wrong' do
      expect(type(Defensor).or(type(Atacante)).call('un delfín')).to eq false
    end

  end

  describe :not do

    it 'should be false if asserts' do
      expect(type(Defensor).not.call(@una_muralla)).to eq false
    end

    it 'should be true if asserts' do
      expect(type(Defensor).call(@una_muralla)).to eq true
    end

    it 'should be true if not asserts' do
      expect(type(Defensor).not.call(@un_misil)).to eq true
    end

    it 'should be false if asserts' do
      expect(type(Defensor).call(@un_misil)).to eq false
    end

  end

end