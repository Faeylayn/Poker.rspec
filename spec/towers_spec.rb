require 'towers'

describe Towers do
  let(:hanoi) { Towers.new }

  it "starts with three towers" do
    expect(hanoi.towers.count).to eq(3)
  end

  it "starts with three disks on the first tower" do
    expect(hanoi.towers[0].count).to eq(3)
  end

  it "has three numbered disks in the descending order" do
    expect(hanoi.towers[0]).to eq ([3, 2, 1])
  end

  describe "#move_disk" do
    it "should move top disk from 1st tower to second tower" do
      hanoi.move_disk(0,1)
      expect(hanoi.towers[0]).to eq([3, 2])
      expect(hanoi.towers[1]).to eq([1])
    end
    it "shouldn't move disk if top disk on second tower is smaller" do
      hanoi.move_disk(0,1)
      expect {hanoi.move_disk(0,1)}.to raise_error("Invalid Move")
    end

    it "shouldn't move a disk from an empty tower" do

      expect{hanoi.move_disk(1,0)}.to raise_error("That tower is empty")
    end
  end

  describe "#finished?" do
    it "should say when the game isn't over" do
      expect(hanoi.finished?).to eq(false)
    end

    it "should say when the game is over" do
      hanoi.towers[2] = [3, 2, 1]
      expect(hanoi.finished?).to eq(true)
    end
  end

  describe "#parse_user_input" do
    it "should read two numbers from a string" do
      expect(hanoi.parse_user_input("1,2")).to eq([1, 2])
    end

    it "should check for valid input"
  end

  describe "#game" do
    # it "should prompt user input" do
    #   expect hanoi.game to receive(:user_input)
    # end
  end

end
