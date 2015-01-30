class Hand
  attr_accessor :cards

  def initialize(deck)
    @deck = deck
    @cards = @deck.deal(5)
  end

  def discard(indices)
    raise 'You can only discard up to 3 cards' if indices.count > 3
    indices.each do |idx|
      @cards[idx] = @deck.deal(1)
    end
  end
end
