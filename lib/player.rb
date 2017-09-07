require_relative 'ship'
require_relative 'board'

class Player
  attr_accessor :shot_count, 
                :ship_arr, 
                :ships

  def initialize(ship_arr)
    @shot_count = 0
    @ship_arr   = ship_arr
    @ships      = []
    ship_yard
  end

  def shoot(board, space)
    @shot_count +=1 
    board.fire_on(space)
  end

  def ship_yard 
    @ships = @ship_arr.map {|length| Ship.new(length)}
  end

  def place_ship(board, ship, bow, stern)
    ship.place(bow, stern)
    board.fill_spaces(bow, stern)
  end

  def loser? 
    @ships.all? {|ship| ship.sunk?}
  end
end