require 'rspec'
require '../src/pattern_matching.rb'

describe :value_matcher do

  describe :with_one_argument do

    it 'should be ValuePattern' do
      expect(val(5).class).to eq(ValuePattern)
    end

    describe :number_cases do

      it 'should be false if different type' do
        expect(val(5).call 'A').to eq false
      end
      it 'should be false if different content' do
        expect(val(5).call 2).to eq false
      end
      it 'should be true if same' do
        expect(val(12).call 12).to eq true
      end

    end

    describe :String_cases do

      it 'should be false if different type' do
        expect(val('Hola mundo').call [1,2,3]).to eq false
      end
      it 'should be false if different content' do
        expect(val('Hola mundo').call 'Impostor').to eq false
      end
      it 'should be true if same' do
        expect(val('Hola mundo').call 'Hola mundo').to eq true
      end

    end

    describe :Array_cases do

      it 'should be false if different type' do
        expect(val([1,2,3,4]).call 'I am an Array').to eq false
      end
      it 'should be false if different content' do
        expect(val([1,2,3,4]).call [1234]).to eq false
      end
      it 'should be true if same' do
        expect(val([1,2,3,4]).call [1,2,3,4]).to eq true
      end

    end

    describe :symbol_cases do

      it 'should be true if different type' do
        expect(val(:symbol).call 19).to eq false
      end
      it 'should be true if different content' do
        expect(val(:symbol).call :same_symbol).to eq false
      end
      it 'should be true if same' do
        expect(val(:symbol).call :symbol).to eq true
      end

    end

  end

end