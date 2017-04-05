#note to self, left side is top (shift/unshift only)

class Game
  attr_accessor :towers
  def initialize(num)
    @max = num
    @towers = [(1..num).to_a, [], []]
  end

  def move_rings(start_tower, end_tower)
    @towers[end_tower].unshift(towers[start_tower].shift)
  end

  def valid_move(start_tower, end_tower)
    case true
    when !start_tower.between?(0,2) || !end_tower.between?(0,2)
      false
    when @towers[start_tower].empty?
      false
    when @towers[start_tower].first > (@towers[end_tower].first || @max + 1 )
      false
    else
      true
    end
  end

  def won?
    towers[0].empty? && (towers[1].empty? || towers[2].empty?)
  end

  def play
    until won?
      begin
        render
        puts "Select a tower to move from and a tower to move to."
        from, to = gets.chomp.split(", ").map(&:to_i)
        raise 'Invalid move' unless valid_move(from, to)
      rescue
        puts 'Please try again'
        retry
      end
      move_rings(from, to)
    end
    render
    puts "You've Won!"
  end

  def render
    @towers.each_with_index do |tower,idx|
      print "Tower: #{idx}"
      p tower
    end
  end

end
game = Game.new(3)
game.play
