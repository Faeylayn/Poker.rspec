class Hand
  attr_accessor :cards

  def initialize(deck)
    @deck = deck
    @cards = @deck.deal(5)
  end


end
