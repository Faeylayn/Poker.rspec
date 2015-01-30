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

  describe "#get_value" do
    it "should recognize pairs" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three)]
      expect(hand.get_value).to eq({:pair => [:three]})
    end

    it "should recognize two pair" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:diamonds, :three),
                    Card.new(:spades, :four),
                    Card.new(:diamonds, :four)]
      expect(hand.get_value).to eq({:two_pair => [:three, :four]})
    end

    it "should recognize three of a kind" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three), Card.new(:hearts, :three)]
      expect(hand.get_value).to eq({:three_of_a_kind => [:three]})
    end

    it "should recognize a straight" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:clubs, :seven),
                    Card.new(:spades, :four),
                    Card.new(:spades, :five),
                    Card.new(:spades, :six)]
      expect(hand.get_value).to eq({:straight => [:seven]})
    end

    it "should recognize a flush" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:spades, :seven),
                    Card.new(:spades, :four),
                    Card.new(:spades, :ten),
                    Card.new(:spades, :jack)]
      expect(hand.get_value).to eq({:flush => :spades})
    end

    it "should recognize a full house" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:diamonds, :three),
                    Card.new(:spades, :four),
                    Card.new(:diamonds, :four),
                    Card.new(:hearts, :three)]
      expect(hand.get_value).to eq({:full_house => [:three, :four]})
    end

    it "should recognize four of a kind" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three), Card.new(:hearts, :three), Card.new(:clubs, :three)]
      expect(hand.get_value).to eq({:four_of_a_kind => [:three]})

    end

    it "should recognize a straight flush"

    it "should recognize high card"

  end

end
