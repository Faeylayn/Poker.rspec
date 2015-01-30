
require 'rspec'
require 'Array'


describe Array do
  subject(:array) {Array.new}



  describe "#my_uniq" do

    it "returns an empty array" do
      expect(array.my_uniq).to eq([])
    end

    it "returns the original array if all elements are unique" do
      expect([1,2,3,4,5].my_uniq).to eq([1,2,3,4,5])
    end

    it "removes duplicate elements" do
      expect([1,3,4,3,1,2].my_uniq).to eq([1,3,4,2])
    end

  end

  describe "#two_sum" do

    it "returns an empty array if no elements sum to 0" do
      expect([1,2,3,4].two_sum).to eq([])
    end

    it "finds a pair that adds to 0" do
      expect([1, 2, -1, 5].two_sum).to eq([[0,2]])
    end

    it "finds multiple pairs in the right order" do
      expect([1,2,3,-1,-2,-3].two_sum).to eq([[0,3], [1,4], [2,5]])
    end

  end


end
