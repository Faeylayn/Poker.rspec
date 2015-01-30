class Towers
  attr_accessor :towers

  def initialize
    @towers = Array.new(3) {[]}

    @towers[0] = [3, 2, 1]
  end

  def move_disk(start_index, place_index)
    start_tower = @towers[start_index]
    place_tower = @towers[place_index]
    if start_tower.empty?
      raise "That tower is empty"
    end

    unless place_tower.last.nil? || start_tower.last < place_tower.last
      raise "Invalid Move"
    end
    place_tower << start_tower.pop

  end

  def finished?
    @towers[2] == [3, 2, 1]
  end

  def parse_user_input(string)
    output = string.split(",")
    output.map do |el|
      el = Integer(el)
    end
  end
end
