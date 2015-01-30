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
    four_value = find_in(4)
    return {:four_of_a_kind => four_value} if four_value.count == 1
    pair_value = find_in(2)
    three_value = find_in(3)
    return {:full_house => three_value + pair_value} if three_value.count == 1 && pair_value.count == 1
    return {:three_of_a_kind => three_value} if three_value.count == 1

    return {:pair => pair_value } if pair_value.count == 1
    return {:two_pair => pair_value } if pair_value.count == 2
  end

  def find_in(num)
    values = Hash.new(0)

    @cards.each do |card|
      values[card.value] += 1
    end

    values.select do |value, count|
      count == num
    end.keys
  end

  # def find_three
  #   values = Hash.new(0)
  #
  #   @cards.each do |card|
  #     values[card.value] += 1
  #   end
  #
  #   values.select do |value, count|
  #     count == 3
  #   end.keys
  # end
  #
  # def find_four
end
