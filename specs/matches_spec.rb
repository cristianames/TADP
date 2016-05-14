require 'rspec'
require '../src/PatternMatching.rb'

include PatternMatching

describe :matches do

  it 'should not allow to access another clauses\' variable' do
  	begin
  	  matches? 5 do
        with(:a, val(4)) {a + 1}
    	with(val(5)) { a } #this fails
    	otherwise { 'should not come here' }
      end
      expect(4).to eq 5
    rescue NameError => e
      expect(5).to eq 5
    end
  end

  it 'should throw an error when no clause matches' do
  	begin
  	  matches? 5 do
  	  	with(val 4) { 'doesnt enter' }
  	  end
  	  expect(4).to eq 5
    rescue NoMatchError => e
      expect(5).to eq 5
    end
  end

  it 'should return the last expression of the matched clause' do
    value = matches? 5 do
      with(:a, val(4)) { a }
      with(:b, val(5)) { b }
      otherwise { 10 }
    end
    expect(value).to eq(5)
  end

  it 'should return the otherwise when no other clause matches' do
    value = matches? 5 do
      with(val(50)) { 15 }
      with(val(100)) { 15 }
      otherwise { 10 }
    end
    expect(value).to eq(10)
  end
end