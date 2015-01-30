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
      expect(hand).to receive(:discard)#.with(:input)

      player.discard
    end
  end

  describe "#discard_parse" do
    it "should return an array of numbers" do
      expect(Player.discard_parse('0,3')).to eq([0,3])
    end
    it "should check for valid input" do
      expect{Player.discard_parse("mystring")}.to raise_error(ArgumentError)
    end
  end


  describe "#fold" do
    it "should send a fold message to the game" do
      game = double(:game)
      player = Player.new
      expect(game).to receive(:fold).with(player)
      player.fold(game)

    end

  end

  describe "#bet" do
    it "should send a bet message to the game" do
      game = double(:game, :current_bet => 10)
      player = Player.new
      expect(game).to receive(:bet).with(player, 50)
      player.bet(game, 50)
    end

    it "should not send a value less than current bet" do
      game = double(:game, :current_bet => 60)
      player = Player.new
      expect { player.bet(game, 50) }.to raise_error("bet too small")
    end

    it "should deduct from bankroll on successful bet" do
      game = double(:game, :current_bet => 10)
      player = Player.new
      expect(game).to receive(:bet).with(player, 50)
      player.bet(game, 50)
      expect(player.bankroll).to eq(50)
    end

    it "should not bet more than its bankroll" do
      game = double(:game, :current_bet => 10)
      player = Player.new
      expect { player.bet(game, 500) }.to raise_error("you don't have enough money")
    end
  end

end
