require_relative 'space'

class Board
  attr_accessor :size

  def initialize(size)
    @size = size
  end

  def rows
    ('A'..'Z').to_a.shift(@size)
  end
  
  def columns
    ('1'..'26').to_a.shift(@size)
  end

  def space_name_arr
    rows.flat_map {|letter| columns.flat_map{|number| letter + number}}
  end

  def space_hash
    space_name_arr.reduce({}) {|spaces, name| spaces["#{name}"] = Space.new(name); spaces}
  end

  def row_arr
    space_name_arr.each_slice(@size).to_a
  end

  def build_game_grid
    row_arr.map do |row|
      row.map.with_index do |coordinates, index|
        row[index] = {coordinates => space_hash[coordinates]}
      end
    end
  end
end

board = Board.new(4)

# p board.row_arr
# p board.build_game_grid