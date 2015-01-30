
class Player
  attr_accessor :bankroll, :hand

  def initialize(bankroll=100)
    @bankroll = bankroll
  end

  def get_hand(hand)
    @hand = hand
  end

  def discard
    @hand.discard
  end

end
