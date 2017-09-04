require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'computer'
require_relative 'validate'

class BattleShip 
  def initialize
    @player         = Player.new([2,3])
    @computer       = Player.new([2,3])
    @computer_board = Board.new(4)
    @player_board   = Board.new(4)
  end
end
