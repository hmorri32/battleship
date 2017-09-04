require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'computer'
require_relative 'validate'
require_relative 'messages'
require 'colorize'

class BattleShip
  include Messages 
  include Validate

  attr_accessor :player, 
                :computer, 
                :computer_board,
                :player_board

  def initialize
    @player         = Player.new([2,3])
    @computer       = Computer.new([2,3])
    @computer_board = Board.new(4)
    @player_board   = Board.new(4)
    ship_placement
  end

  def ship_placement 
    computer_ships
    player_ships
  end
  
  def computer_ships 
    computer.ships.each do |ship|
      spaces = computer.position(computer_board, ship)
      computer.place_ship(computer_board, ship, spaces[0], spaces[1])
    end
    puts Messages.computer_has_placed_ships.colorize(:red)
  end

  def player_ships 
    player.ships.each do |ship|
      spaces = validate_input(ship)
      player.place_ship(player_board, ship, spaces[0], spaces[1])
      puts "\n You have placed your #{ship.length} unit ship at #{spaces[0]} #{spaces[1]}".colorize(:blue)
    end
  end

  def validate_input(ship)
    dale = false 
    until dale 
      puts Messages.place_ship(ship) 
      answer = gets.chomp.upcase.split(" ")
      dale = valid_space?(player_board, ship, answer)
    end
    return answer
  end

  def valid_space?(board, ship, answer)
    validity  = false
    input     = valid_gets?(board, ship, answer)
    direction = valid_direction?(answer)      if input
    length    = length?(board, ship, answer)  if direction
    validity  = overlap?(board, ship, answer) if length
    return validity
  end

  def length?(board, ship, answer)
    if !valid_length?(board, ship, answer[0], answer[1])
      puts "\n Error, ship length invalid!".colorize(:red)
      return false
    end
    return true
  end

  def overlap?(board, ship, answer)
    if !no_overlap?(board, ship, answer[0], answer[1])
      puts "\nThat space is already occupied!".colorize(:red)
      return false
    end
    return true
  end

  def valid_direction?(answer)
    if !no_diagonals?(answer[0], answer[1])
      puts "\n Error, No diagonal placement!".colorize(:red)
      return false
    end
    return true
  end

  def valid_gets?(board, ship, answer)
    if !two_valid_spaces?(board, answer[0], answer[1])
      if answer.length < 2 
        puts "\nError, Please input two spaces".colorize(:red)
        return false 
      else 
        puts "\nError, Space Invalid.".colorize(:red)
        return false
      end
    end
    return true
  end
end
