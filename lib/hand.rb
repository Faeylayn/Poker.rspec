class Hand
  attr_accessor :cards

  def initialize(deck)
    @deck = deck
    @cards = @deck.deal(5)
  end

  def discard(indices)
    indices.each do |idx|
      @cards[idx] = @deck.deal(1)
    end
  end
end
