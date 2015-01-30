require 'stock_picker'

describe "#stock_picker" do
  it "tells you if there are no good buys" do
    expect(stock_picker([])).to eq("No profits here")
  end

  it "correctly finds the best profits" do
    prices = [20, 40, 10, 60, 30, 10]
    expect(stock_picker(prices)).to eq([2, 3])
  end

  it "won't return a result if the sell price is before the buy price" do
    prices = [50, 40, 30, 20, 10]
    expect(stock_picker(prices)).to eq("No profits here")
  end

end
