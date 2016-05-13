require 'rspec'
require '../src/pattern_matching.rb'

describe :list_matcher do

  before :all do
    @an_array = [1, 2, 3, 4, 5]
  end

  describe :with_one_argument do

    it 'should be ListPattern' do
      expect(list([1,2,3,4,5]).class).to eq(ListPattern)
    end
    it 'should be false if different size of contents' do
      expect(list([1,2,3,4]).call @an_array).to eq false
    end
    it 'should be true if same size of content' do
      expect(list([1,2,3,4,5]).call @an_array).to eq true
    end
    it 'should be false when are in different order' do
      expect(list([5,4,3,2,1]).call @an_array).to eq false
    end

  end

  describe :with_two_arguments do

    it 'should be true if pass false and got same first N elements' do
      expect(list([1,2,3], false).call @an_array).to eq true
    end
    it 'should be false if pass true even if we have got same first N elements' do
      expect(list([1,2,3], true).call @an_array).to eq false
    end
    it 'should be false when dont have the same first N elements' do
      expect(list([5,4,3], false).call @an_array).to eq false
    end
    it 'should be false when passing an array longer than the second one' do
      expect(list([1,2,3,4,5,6], false).call @an_array).to eq false
    end

  end

end
