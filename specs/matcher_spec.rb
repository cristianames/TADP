require 'rspec'
require '../src/Matcher.rb'

describe :variable_call do

  describe :with_no_arguments do

    it 'should say true' do
      expect(Matcher.variable.match?()).to eq(true)
    end

  end

  describe :with_one_argument do

    it 'should say true' do
      expect(Matcher.variable.match?(5)).to eq(true)
    end

  end

  describe :with_many_arguments do

    it 'should say true' do
      expect(Matcher.variable.match?('Hello', 12, Object.new)).to eq(true)
    end
  end

end

describe 'Matcher valor' do
  a = Matcher.val(5)
describe 'expected true' do
  it 'verify 5' do
    expect(a.match?(5)).to eq(true)
  end
end
describe 'expected false' do
  it 'verify Fixnum isnt equals to string' do

    expect(a.match?('5')).to eq(false)
  end
end

describe 'expected true' do
  it 'verify symbols' do
    expect(Matcher.val(:any).match?(:any)).to eq(true)
  end
end

describe 'expected false' do
  it 'verify 5 isnt equals to 4' do
    expect(a.match?(4)).to eq(false)
  end
end
end

describe 'matcher de tipo' do

  describe 'expected true' do
    it 'verify Integer' do
      expect(Matcher.type(Fixnum).match?(4)).to eq(true)
    end
  end

  describe 'expected false' do
    it 'verify Symbol' do
      expect(Matcher.type(Symbol).match?('a')).to eq (false)
    end

  end
  describe 'expected true' do
    it 'verify symbol' do
      expect(Matcher.type(Symbol).match?(:a)).to eq(true)
    end
  end
end

describe 'matcher de listas' do

  describe 'expected true' do
    it 'verify list without length' do
      expect(Matcher.list([1,2,3,4]).match?([1,2,3,4])).to eq(true)
    end
  end
  describe 'expected true' do
    it 'verify list without length' do
      expect(Matcher.list([1,2,3]).match?([1,2,3,4])).to eq(true)
    end
  end

  describe 'expected true' do
    it 'verify list with length' do
      expect(Matcher.list([1,2,3,4], true).match?([1,2,3,4])).to eq(true)
    end
  end

  describe 'expected true' do
    it 'verify list without length' do
      expect(Matcher.list([1,2,3], false).match?([1,2,3,4])).to eq(true)
    end
  end

end

describe 'matcher de metodos' do

  describe 'expected true' do
    it 'Object understand .to_s' do
      expect(Matcher.duck(:to_s).match?(Object.new)).to eq(true)
    end
  end

  describe 'expected true' do
    it 'Array understand size and map' do
      expect(Matcher.duck(:size, :map ).match?(Array.new)).to eq(true)
    end
  end

  describe 'expected true' do
    it 'Object dont understand size' do
      expect(Matcher.duck(:to_s, :size).match?(Object.new)).to eq(false)
    end
  end
end

describe 'matcher or' do

  describe 'expected true' do
    it '' do
      expect(Matcher.or(Matcher.duck(:size, :map), Matcher.val(5)).match?(Array.new)).to eq(true)
    end
  end
  describe 'expected false' do
    it '' do
      expect(Matcher.or(Matcher.duck(:size, :map), Matcher.val(5)).match?(Object.new)).to eq(false)
    end
  end
  describe 'expected true' do
    it '' do
      expect(Matcher.or(Matcher.duck(:size, :map), Matcher.val([5,2]), Matcher.type(Array)).match?([5])).to eq(true)
    end
  end
end
describe ''do
  describe 'expected true' do
    it '' do
      expect(Matcher.and(Matcher.duck(:size, :map), Matcher.val(5)).match?(Object.new)).to eq(false)
    end
  end
  describe 'expected false' do
    it '' do
      expect(Matcher.and(Matcher.duck(:size, :to_s), Matcher.val(5)).match?(Object.new)).to eq(false)
    end
  end
  describe 'expected true' do
    it '' do
      expect(Matcher.and(Matcher.duck(:size, :map), Matcher.val([5,2]), Matcher.type(Array)).match?([5,2])).to eq(true)
    end
  end
  describe 'expected true' do
    it '' do
      expect(Matcher.or(Matcher.duck(:size, :map), Matcher.list([5,2]), Matcher.type(Array)).match?([5])).to eq(true)
    end
  end
end

describe 'Matcher not' do
  describe 'expected true' do
    it '' do
      expect(Matcher.not(Matcher.duck(:size, :map)).match?([Array.new])).to eq(false)
    end
  end
end






