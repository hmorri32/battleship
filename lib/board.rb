require_relative 'space'
require_relative 'board_builder'

class Board
  include BoardBuilder

  attr_accessor :size, 
                :board

  def initialize(size)
    @size  = size
    @board = build_board
  end

  def get_space(spot)
    @board.map do |row|
      row.find {|space_hash| space_hash[spot]}
    end.compact[0][spot]
  end
  
  def space_exists?(space)
    space_name_arr.include?(space)
  end
  
  def fill_space(position)
    get_space(position).full = true
  end

  def fill_spaces(one, two)
    if same_row?(one, two)
      fill_row(one, two)
    else
      fill_column(one, two)
    end
  end

  def fill_row(one, two)
    all_spaces_flat(one, two).each {|space| fill_space(space)}
  end
  
  def fill_column(one, two)
    all_spaces_vertical(one, two).each {|space| fill_space(space)}
  end

  def space_full?(position)
    get_space(position).full
  end

  def get_spaces(one, two)
    if same_row?(one, two)
      all_spaces_flat(one, two)
    elsif same_column?(one, two)
      all_spaces_vertical(one, two)
    end
  end

  def all_spaces_flat(one, two)
    nums = (one[1]..two[1]).to_a
    nums.map {|num| one[0] + num}
  end
  
  def all_spaces_vertical(one, two)
    letters = (one[0]..two[0]).to_a
    letters.map {|letter| letter + one[1]}
  end
  
  def same_row?(one, two)
    one[0] == two[0]
  end

  def same_column?(one, two)
    one[1] == two[1]
  end

  def span_horizontally(one, two)
    return unless same_row?(one, two)
    spot_1 = one[1].to_i
    spot_2 = two[1].to_i
    subtract(spot_1, spot_2)
  end

  def span_vertically(one, two)
    return unless same_column?(one, two)
    spot_1 = rows.index(one[0])
    spot_2 = rows.index(two[0])
    subtract(spot_1, spot_2)
  end

  def subtract(spot_1, spot_2)
    if spot_1 < spot_2 
      (spot_2 - spot_1) + 1
    else
      (spot_1 - spot_2) + 1
    end
  end

  def fired_on?(space)
    get_space(space).fired_on
  end

  def fire_on(space)
    get_space(space).fired_on = true
  end

  def hit?(space)
    fired_on?(space) && space_full?(space)
  end
  
  def miss?(space)
    fired_on?(space) && !space_full?(space)
  end
end