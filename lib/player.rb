require_relative 'ship'

class Player
  attr_accessor :shot_count, :ship_arr

  def initialize(ship_arr = nil)
    @shot_count = 0
    @ship_arr   = ship_arr
    @ships      = []
  end

  def shoot 
    @shot_count +=1 
  end

  def ship_builder 
    @ships = @ship_arr.map {|length| Ship.new(length)}
  end
  
  def total_ships
    @ships.length
  end
end