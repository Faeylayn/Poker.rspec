require 'my_transpose'

describe "#my_transpose" do
  it "returns and empty matrix if given an empty matrix" do
    expect(my_transpose([[]])).to eq([[]])
  end

  it "transposes a matrix" do
    rows = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    cols = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
    expect(my_transpose(rows)).to eq(cols)
  end

end
