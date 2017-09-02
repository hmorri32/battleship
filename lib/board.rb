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

  def space_exists?(space)
    space_name_arr.include?(space)
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

  def north?(spot)
    rows.index(spot[0]) > 0
  end

  def north_coordinates(spot)
    letter = rows.index(spot[0]) - 1  
    number = spot[-1]
    rows[letter] + number
  end
  
  def south?(spot)
    rows.index(spot[0]) < @size -1
  end

  def south_coordinates(spot)
    letter = rows.index(spot[0]) + 1  
    number = spot[-1]
    rows[letter] + number
  end
  
  def east?(spot)
    spot[-1].to_i > 0 && spot[-1].to_i < @size
  end

  def east_coordinates(spot)
    spot[0] + (spot[-1].to_i + 1).to_s
  end

  def west?(spot)
    spot[-1].to_i > 1
  end

  def west_coordinates(spot)
    spot[0] + (spot[-1].to_i - 1).to_s
  end

  def neighbors(spot)
    neighbors = Array.new 
    neighbors << north_coordinates(spot) if north?(spot)
    neighbors << south_coordinates(spot) if south?(spot)
    neighbors << east_coordinates(spot)  if east?(spot)
    neighbors << west_coordinates(spot)  if west?(spot)
    neighbors
  end

  def get_space(spot)
    build_game_grid.map do |row|
      row.find {|space_hash| space_hash[spot]}
    end.compact[0][spot]
  end
end

# board = Board.new(4)
# p board.space_exists?('Z3')