require_relative 'player'
require_relative 'board'

class Computer < Player 

  def random_space(board)
    board.space_name_arr.sample
  end

  def pick_spaces(board, history = [])
    spaces = board.space_name_arr
    until spaces.length == 0 do
      spaces.pop
    end

  end

end

board = Board.new(4)
c = Computer.new([2,3])
p c.pick_spaces(board)