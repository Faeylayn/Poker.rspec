
class Player

  def self.discard_parse(string)
    output = string.split(",")
    output.map do |el|
      el = Integer(el)
    end
  end

  attr_accessor :bankroll, :hand

  def initialize(bankroll=100)
    @bankroll = bankroll
  end

  def get_hand(hand)
    @hand = hand
  end

  def discard
    # input = self.class.discard_parse(gets.chomp)
    @hand.discard
  end

  def fold(game)
    game.fold(self)
  end

  def bet(game, amount)
    raise "you don't have enough money" if amount > @bankroll
    raise 'bet too small' if amount < game.current_bet
    game.bet(self, amount)
    @bankroll -= amount
  end


end
