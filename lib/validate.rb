require_relative 'ship'
require_relative 'player'
require_relative 'board'

module Validate
  def valid_space?(board, space)
    board.space_exists?(space)
  end
end