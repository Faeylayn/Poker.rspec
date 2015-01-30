require 'deck'

describe Deck do
  let(:deck) { Deck.new }

  it "should initialize with a full deck" do
    expect(deck.cards.count).to eq(52)
  end

  describe "#deal" do
    it "should deal the correct amount of cards" do
      hand = deck.deal(5)
      expect(hand.count).to eq(5)
    end

    it "should remove the cards from available cards" do
      hand = deck.deal(5)
      expect(deck.cards.count).to eq(47)
    end

    it "should not deal more cards than there are in the deck" do
      expect { deck.deal(53) }.to raise_error("there are not enough cards in the deck")
    end
  end

end
