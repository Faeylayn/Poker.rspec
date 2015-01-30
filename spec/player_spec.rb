require 'player'

describe Player do

  it "starts with a bankroll" do
    player = Player.new
    expect(player.bankroll).to eq(100)
  end

  describe "#get_hand" do
    it "should give the player a hand of 5 cards" do
      player = Player.new
      hand = [1, 2, 3, 4, 5]
      player.get_hand(hand)
      expect(player.hand).to eq([1, 2, 3, 4, 5])
    end
  end

  describe "#discard" do
    it "calls the discard method on the hand" do
      player = Player.new
      hand = double(:hand)
      player.get_hand(hand)
      expect(hand).to receive(:discard)

      player.discard
    end
  end

  describe "#discard_parse" do
    it "should return an array of numbers"
  end
end
