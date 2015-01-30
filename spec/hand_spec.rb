require 'hand'
require 'card'

describe Hand do


  it "starts by drawing five cards" do
    deck = double('deck')
    # let(:hand) {Hand.new(deck)}
    cards = [
      Card.new(:spades, :three),
      Card.new(:spades, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :six),
      Card.new(:spades, :seven)

    ]


    allow(deck).to receive(:deal).with(5).and_return(cards)

    hand = Hand.new(deck)
    expect(hand.cards.count).to eq(5)

  end

end
