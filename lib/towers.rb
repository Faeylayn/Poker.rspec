class Towers
  attr_accessor :towers

  def initialize
    @towers = Array.new(3) {[]}

    @towers[0] = [3, 2, 1]
  end

  def move_disk(start_index, place_index)
    start_tower = @towers[start_index]
    place_tower = @towers[place_index]
    if start_tower.nil? || place_tower.nil?
      raise "That tower doesn't exist"
    end

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

  def game

    until finished?
      puts "Input your move."
      p @towers

      begin
        start_tower, place_tower = parse_user_input(gets.chomp)
        move_disk(start_tower, place_tower)
      rescue StandardError => e
        puts e.message
        retry
      end
    end
    puts "GAME OVER! YOU LOSE! YOU GET NOTHING! GOOD DAY SIR!"
    puts @towers
    puts "Just Kidding, You won."
  end

end
