require_relative 'player'
require_relative 'board'

class Computer < Player 

  def random_space(board)
    board.space_name_arr.sample
  end

  def choose_spaces(board, history = [])
    spaces = board.space_name_arr
    return history if spaces.length == history.length
    space = random_space(board)
    history << space if !history.include?(space)
    choose_spaces(board, history)
  end

  def empty_space(board)
    choose_spaces(board).find {|space| !board.space_full?(space)}
  end

  def coordinates_flat(board, one, length)
    choose_spaces(board).find do |two|
      !board.space_full?(one) && board.span_horizontally(one, two) == length
    end
  end

  def coordinates_vertical(board, one, length)
    choose_spaces(board).find do |two|
      !board.space_full?(one) && board.span_vertically(one, two) == length
    end
  end

  def coordinates(board, ship)
    one = empty_space(board)
    two = coordinates_flat(board, one, ship.length)
    [one, two].sort
  end
  # def not_attacked(board)
  # end


end

# board = Board.new(4)
# c = Computer.new([2,3])
# p c.pick_spaces(board)
# p c.pick_empty_space(board)