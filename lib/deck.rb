require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    full_deck
  end

  def full_deck
    @cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def deal(num)
    hand = []
    raise "there are not enough cards in the deck" if num > @cards.count
    num.times do
      hand << @cards.shuffle!.pop
    end

    hand
  end
end
