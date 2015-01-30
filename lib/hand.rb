


class Hand

  HAND_VALUE = [
    :high_card,
    :pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_a_kind,
    :straight_flush
  ]

  attr_accessor :cards, :hand_order

  def self.winner(hands)
    until hands.count == 1
      hand1 = hands.pop
      hand2 = hands.pop

      value1 = hand1.get_value
      value2 = hand2.get_value
      if HAND_VALUE.index(value1.keys[0]) > HAND_VALUE.index(value2.keys[0])
        hands << hand1
      elsif HAND_VALUE.index(value1.keys[0]) < HAND_VALUE.index(value2.keys[0])
        hands << hand2
      else
        high_card_hand1 = HAND_VALUE.index(hand1.find_high_card)
        high_card_hand2 = hand2.find_high_card
#if HAND_VALUE.index(high_card_hand1) > HAND_VALUE.index()
  #      end
      end
    end

    hands[0]
  end

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
    highest_straight = find_straight
    return {:straight_flush => [highest_straight] } if is_flush?(@cards[0].suit) && !highest_straight.nil?
    return {:straight => [highest_straight] } unless highest_straight.nil?
    return {:flush => @cards[0].suit } if is_flush?(@cards[0].suit)
    four_value = find_in(4)
    return {:four_of_a_kind => four_value} if four_value.count == 1
    pair_value = find_in(2)
    three_value = find_in(3)
    return {:full_house => three_value + pair_value} if three_value.count == 1 && pair_value.count == 1
    return {:three_of_a_kind => three_value} if three_value.count == 1

    return {:pair => pair_value } if pair_value.count == 1
    return {:two_pair => pair_value } if pair_value.count == 2
    return {:high_card => [find_high_card] }

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

  def is_flush?(suit)
    @cards.all? { |card| card.suit == suit }
  end

  def find_straight
    poker_values = @cards.map { |card| card.poker_value }
    poker_values.sort!

    4.times do |card_idx|
      return nil if poker_values[card_idx] + 1 != poker_values[card_idx + 1]
    end

    Card::POKER_VALUE.invert[poker_values.last]
  end

  def find_high_card
    poker_values = @cards.map { |card| card.poker_value }
    poker_values.sort!
    Card::POKER_VALUE.invert[poker_values.last]
  end

  def order_hand
    values = @cards.map {|card| card.poker_value}
    values.sort!.reverse!
    if [:four_of_a_kind, :full_house, :two_pair, :three_of_a_kind, :pair].include?(get_value.keys[0])
      values.sort do |v1, v2|
        if values.count(v2) == values.count(v1)
          v2 <=> v1
        else
         values.count(v2) <=> values.count(v1)
        end
      end
    else
      values.sort!.reverse!
    end
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
