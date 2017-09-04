require_relative 'player'
require_relative 'board'

class Computer < Player 

  def random_space(board)
    board.space_name_arr.sample
  end

  

end

board = Board.new(4)
c = Computer.new([2,3])
p c.random_space(board)