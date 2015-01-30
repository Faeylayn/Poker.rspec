require 'hand'
require 'card'

describe Hand do
  let(:deck) { double('deck')}
  let(:cards) {[
    Card.new(:spades, :three),
    Card.new(:spades, :four),
    Card.new(:spades, :five),
    Card.new(:spades, :six),
    Card.new(:spades, :seven)
  ]}


  it "starts by drawing five cards" do

    allow(deck).to receive(:deal).with(5).and_return(cards)

    hand = Hand.new(deck)
    expect(hand.cards.count).to eq(5)

  end

  describe "#discard" do
    it "should get rid of cards that are being discarded" do

      allow(deck).to receive(:deal).with(5).and_return(cards)
      allow(deck).to receive(:deal).with(1).and_return(cards.sample)

      hand = Hand.new(deck)
      hand.cards = [:test1, :test2, :test3]
      hand.discard([0])
      expect(hand.cards.include?(:test1)).to eq(false)
    end

    it "should replace the discarded cards" do

      redraw = Card.new(:spades, :eight)
      allow(deck).to receive(:deal).with(5).and_return(cards)
      allow(deck).to receive(:deal).with(1).and_return(redraw)

      hand = Hand.new(deck)
      hand.cards = [:test1, :test2, :test3]
      hand.discard([0])
      expect(hand.cards.include?(redraw)).to eq(true)
    end

    it "should not discard more than three cards" do
      allow(deck).to receive(:deal).with(5).and_return(cards)
      allow(deck).to receive(:deal).with(1).and_return(cards.sample)
      hand = Hand.new(deck)
      expect{hand.discard([0,1,2,3])}.to raise_error('You can only discard up to 3 cards')

    end
  end

end
