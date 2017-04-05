require 'rspec'
require 'tdd.rb'
describe Array do

  describe 'Array#my_uniq' do
    it 'returns an array with no duplicate elements' do
      array = [1,2,3,4,5,1,2,3]
      expect(array.my_uniq).to eq([1,2,3,4,5])
    end
    it 'returns the array in the correct order' do
      array2 = [3,2,1,1]
      expect(array2.my_uniq).to eq([3,2,1])
    end

  end
  describe 'Array#two_sum' do
    let(:array){ [-1, 0, 2, -2, 1] }
    it 'returns smaller indexes first' do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
    it 'returns only the correct index pairs' do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end

  end

  describe 'Array#my_transpose' do
    let(:matrix) { [[1,2], [3,4]] }
    let(:random_matrix) do
      a = Array.new(9) { rand(100) }
      a.each_slice(3).to_a
    end

    it 'returns the array transposed' do
      expect(matrix.my_transpose).to eq([[1,3],[2,4]])
    end

    it 'it works for various arrays of random values' do
      expect(random_matrix.my_transpose).to eq(random_matrix.transpose)
    end


  end

  describe 'Array#stock_picker' do

    it 'returns an array of length 2' do
      expect([0,1,2,3].stock_picker.length).to eq(2)
    end

    it 'the sell date is after the buy date' do
      testoutput = [0,1,2,3].stock_picker

      expect(testoutput[0] < testoutput[1]).to be(true)
    end
    context 'works for multiple stock price arrangements' do

      it 'returns the greatest profit when the lowest is not the first the element' do
        expect([20,5,35].stock_picker).to eq([1,2])
      end

      it 'does not simply pick the largest and smallest values' do
        expect([9999, 1, 2, 500, 3, 5].stock_picker).not_to eq([0, 1])
      end

      it 'returns [] if the stock price never changes' do
        expect([1,1,1,1,1].stock_picker).to eq([])
      end

      it 'returns the earliest combination of dates if there multiple sharing the greatest difference' do
        expect([1,2,1,2,1,2].stock_picker).to eq([0,1])
      end
    end
  end



end
