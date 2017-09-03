require_relative 'ship'
require_relative 'board'

class Player
  attr_accessor :shot_count, :ship_arr, :ships

  def initialize(ship_arr)
    @shot_count = 0
    @ship_arr   = ship_arr
    @ships      = []
    ship_yard
  end

  def shoot 
    @shot_count +=1 
  end

  def ship_yard 
    @ships = @ship_arr.map {|length| Ship.new(length)}
  end
  
  def total_ships
    @ships.length
  end

  def place_ship(board, ship, bow, stern)
    ship.place(bow, stern)
    board.fill_spaces(bow, stern)
  end
end