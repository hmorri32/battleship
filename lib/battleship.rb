require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'computer'
require_relative 'validate'
require_relative 'messages'
require 'colorize'

class BattleShip
  include Messages 

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
    # play
  end

  def ship_placement 
    computer_ships
    player_ships
  end
  
  def computer_ships 
    computer.ships.each do |ship|
      spaces = computer.coordinates(computer_board, ship)
      computer.place_ship(computer_board, ship, spaces[0], spaces[1])
    end
    puts Messages.computer_has_placed_ships.colorize(:red)
  end

  def player_ships 
    player.ships.each do |ship|
      # spaces = gets.chomp
      validate_input(ship)
      # p ship
      # player.place_ship(player_board, ship, spaces[0], spaces[1])
    end
  end

  def validate_input(ship)
    valid = false 
    
    puts Messages.place_ship(ship) 
    answer = gets.chomp.upcase.split(" ")
    valid_space?(player_board, ship, answer)
  end

  def valid_space?(board, ship, answer)
    # on the map 
    #  not diagonal 
    # valid length 
    # not overlapping 
    
  end

  def play

    # until game_over?(player, computer) do 
    
    p 'fook!'
  end

  def place_ships 

  end

  # game_runner
end
