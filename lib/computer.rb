require_relative 'player'
require_relative 'board'
require_relative 'ship'

class Computer < Player 

  def random_space(board)
    board.space_name_arr.sample
  end

  def choose_spaces(board, history = [])
    spaces = board.space_name_arr
    return history if spaces.length == history.length
    space  = random_space(board)
    history << space if !history.include?(space)
    choose_spaces(board, history)
  end

  def empty_space(board)
    choose_spaces(board).find {|space| !board.space_full?(space)}
  end

  def position_flat(board, one, length)
    choose_spaces(board).find do |two|
      !board.space_full?(two) && board.span_horizontally(one, two) == length
    end
  end

  def position_vertical(board, one, length)
    choose_spaces(board).find do |two|
      !board.space_full?(two) && board.span_vertically(one, two) == length
    end
  end
  
  def shuffler
    [true, false, true, false, true, false].shuffle
                                           .shuffle
                                           .shuffle
                                           .shuffle
                                           .shuffle
                                           .shuffle
                                           .pop
  end

  def rando_flat_vertical(board, one, length)
    bool = shuffler
    if bool 
      position_flat(board, one, length)
    else
      position_vertical(board, one, length)
    end
  end

  def position(board, ship)
    one = empty_space(board)
    two = rando_flat_vertical(board, one, ship.length)
    if [one, two].include?(nil)
      one = empty_space(board)
      two = rando_flat_vertical(board, one, ship.length)
    end
    [one, two].sort
  end

  def not_attacked(board)
    choose_spaces(board).find {|space| !board.fired_on?(space)}
  end
end

board = Board.new(4)
c = Computer.new([2,3])
ship = c.ships[0]
ship2 = c.ships[1]
p c.position(board, ship)
p c.position(board, ship2)
# p c.rando_flat_vertical(board, 'a1', 3)
# p c.pick_empty_space(board)