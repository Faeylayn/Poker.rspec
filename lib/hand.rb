class Hand
  attr_accessor :cards

  def initialize(deck, full=true)
    @deck = deck
    @cards = []
    @cards = @deck.deal(5) if full
  end

  def discard(indices)
    raise 'You can only discard up to 3 cards' if indices.count > 3
    indices.each do |idx|
      @cards[idx] = @deck.deal(1)
    end
  end

  def get_value
    pair_value = find_pair
    return {:pair => pair_value } if pair_value.count == 1
  end

  def find_pair
    values = Hash.new(0)

    @cards.each do |card|
      values[card.value] += 1
    end

    values.select do |value, count|
      count == 2
    end.keys
  end
end
