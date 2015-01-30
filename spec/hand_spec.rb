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

    it "should recognize a straight flush" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:spades, :seven),
                    Card.new(:spades, :four),
                    Card.new(:spades, :five),
                    Card.new(:spades, :six)]

      expect(hand.get_value).to eq({:straight_flush => [:seven]})
    end

    it "should return high card if no other values present" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:clubs, :seven),
                    Card.new(:spades, :four),
                    Card.new(:spades, :ten),
                    Card.new(:spades, :jack)]
      expect(hand.get_value).to eq({:high_card => [:jack]})
    end

  end


  describe "#winner" do
    it "should find a winning hand if a hand value is higher than another" do
      hand1 = Hand.new(deck, false)
      hand1.cards = [Card.new(:spades, :three),
                     Card.new(:spades, :seven),
                     Card.new(:spades, :four),
                     Card.new(:spades, :ten),
                     Card.new(:spades, :jack)]
      hand2 = Hand.new(deck, false)
      hand2.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three)]

      expect(Hand.winner([hand1, hand2])).to eq(hand1)
    end

    it 'should find a winning hand when hand value is tied' do
      hand1 = Hand.new(deck, false)
      hand1.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three), Card.new(:hearts, :king)]
      hand2 = Hand.new(deck, false)
      hand2.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three), Card.new(:hearts, :five)]

      expect(Hand.winner([hand1, hand2])).to eq(hand1)
    end

    it 'should return all winning hands when hands are tied'

  end

  describe "#order_hand" do
    it "should order cards in a hand without any matching value" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                     Card.new(:spades, :seven),
                     Card.new(:spades, :four),
                     Card.new(:spades, :ten),
                     Card.new(:spades, :jack)]

      expect(hand.order_hand).to eq([11, 10, 7, 4, 3])
    end

    it "should order a four of a kind in front of other cards" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three), Card.new(:diamonds, :three), Card.new(:hearts, :three), Card.new(:clubs, :three), Card.new(:clubs, :king)]
      expect(hand.order_hand).to eq([3, 3, 3, 3, 13])

    end

    it "should order full house properly" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:diamonds, :three),
                    Card.new(:spades, :four),
                    Card.new(:diamonds, :four),
                    Card.new(:hearts, :three)]
      expect(hand.order_hand).to eq([3, 3, 3, 4, 4])
    end

    it "should order two pair properly" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:diamonds, :four),
                    Card.new(:spades, :three),
                    Card.new(:diamonds, :four),
                    Card.new(:hearts, :king)]
      expect(hand.order_hand).to eq([4, 4, 3, 3, 13])
    end

    it "should order three-of-a-kind properly" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:spades, :ace),
                    Card.new(:diamonds, :three),
                    Card.new(:hearts, :three),
                    Card.new(:diamonds, :queen)]
      expect(hand.order_hand).to eq([3, 3, 3, 14, 12])
    end
    it "should order hands with a pair properly" do
      hand = Hand.new(deck, false)
      hand.cards = [Card.new(:spades, :three),
                    Card.new(:diamonds, :three),
                    Card.new(:spades, :seven),
                    Card.new(:diamonds, :four),
                    Card.new(:hearts, :king)]
      expect(hand.order_hand).to eq([3, 3, 13, 7, 4])
    end

  end
end
