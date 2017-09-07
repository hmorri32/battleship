require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'draw'

class DashBoard 
  include Draw

  def hit?(board, space)
    board.hit?(space)
  end

  def miss?(board, space)
    board.miss?(space)
  end

  def empty?(board, space)
    board.fired_on?(space) == false
  end
end