require_relative 'ship'
require_relative 'player'
require_relative 'board'

module Validate
  def valid_space?(board, space)
    board.space_exists?(space)
  end

  def two_valid_spaces?(board, space_1, space_2)
    board.space_exists?(space_1) && board.space_exists?(space_2)
  end

  def no_diagonals?(space_1, space_2)
    space_1[0] == space_2[0] || space_1[1] == space_2[1]
  end

  def valid_length?(board, ship, space_1, space_2)
    if board.same_row?(space_1, space_2)
      ship.length == board.span_horizontally(space_1, space_2)
    else
      ship.length == board.span_vertically(space_1, space_2)
    end
  end

  def no_overlap?(board, ship, bow, stern)
    board.get_spaces(bow, stern).none? do |space|
      board.space_full?(space)
    end
  end

  def game_over?(one, two)
    one.loser? || two.loser?
  end
end