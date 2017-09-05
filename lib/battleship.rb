require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'computer'
require_relative 'validate'
require_relative 'messages'
require_relative 'dashboard'
require          'pry'
require          'colorize'

class BattleShip
  include Messages 
  include Validate

  attr_accessor :player, 
                :computer, 
                :computer_board,
                :player_board,
                :dash_board

  def initialize
    @player         = Player.new([2,3])
    @computer       = Computer.new([2,3])
    @computer_board = Board.new(4)
    @player_board   = Board.new(4)
    @dash_board     = DashBoard.new
    @time           = Time.new
    ship_yard
    game_flow
  end

  def ship_yard 
    c_ships
    p_ships
  end
  
  def c_ships 
    # TODO - DEBUG THIS> SOMETIMES DOES NOT WORk. 
    computer.ships.each do |ship|
      spaces = computer.position(computer_board, ship)
      spaces = valid_computer_placement?(computer_board, ship, spaces)
      computer.place_ship(computer_board, ship, spaces[0], spaces[1])
      p computer_board
    end
    puts Messages.computer_has_placed_ships.colorize(:red)
  end

  def valid_computer_placement?(board, ship, spaces)
    validity = false
    until validity
      direction = valid_direction?(spaces)
      length    = length?(board, ship, spaces)  if direction
      validity  = overlap?(board, ship, spaces) if length      
    end
    return spaces
  end

  def p_ships 
    player.ships.each do |ship|
      spaces = validate_input(ship)
      player.place_ship(player_board, ship, spaces[0], spaces[1])
      puts "\n You have placed your #{ship.length} unit ship at #{spaces[0]} #{spaces[1]}".colorize(:blue)
    end
  end

  def validate_input(ship)
    dale = false 
    until dale 
      puts Messages.place_ship(ship) + "\n"
      answer = gets.chomp.upcase.split(" ")
      dale   = valid_space?(player_board, ship, answer)
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

  def game_flow 
    color = ''
    
    loser = false
    until loser
      on_deck = player_firing 
      on_deck['player'] == computer ? color = :red : color = :blue
      space = space_to_fire_on(on_deck['player'])
      on_deck['player'].shoot(on_deck['board'], space)
      
      puts "\nYOU fired upon space #{space}".colorize(color) if on_deck['player'] == player
      puts "\nCOMPUTER fired upon space #{space}".colorize(color) if on_deck['player'] == computer

      if dash_board.hit?(on_deck['board'], space)
        puts 'HIT!'.colorize(color)
        ship_stats(on_deck['board'], on_deck['enemy'], space, color)
      else 
        puts 'MISS!'.colorize(color)
      end
      
      puts dash_board.draw(on_deck['board']).colorize(color)
      turn_over(on_deck['player'])
      loser = on_deck['enemy'].loser? || on_deck['player'].loser?
      # TODO = GAME OVER SEQUENCE YO 
    end
  end

  def turn_over(player)
    return if player == computer
    puts "\nPRESS ENTER TO END TURN.".colorize(:blue)
    answer = gets
    return if answer == "\n"
    turn_over(player)
  end

  def ship_stats(board, enemy, space, color)
    ship = get_ship(board, enemy, space)
    puts "Ship's damage total is #{ship.length}!".colorize(color)
    ship.strike 
    puts "Ship's damage is now at #{ship.damage}!".colorize(color)
  end

  def get_ship(board, player, space)
    player.ships.find do |ship|
      bow    = ship.bow
      stern  = ship.stern
      spaces = board.get_spaces(bow, stern)
      spaces.include?(space)
    end
  end

  def space_to_fire_on(player)
    if player == computer 
      computer.not_attacked(player_board)
    else 
      human_target(player, computer_board)
    end
  end

  def human_target(player, computer_board, validity = false)
    return if validity
    render_board(player, computer_board)
    puts "\nEnter the space you wish to fire upon. IE: A2\n\n"
    space = gets.chomp.upcase
    exit if space == 'Q'
    validity = validated_space?(computer_board, space)
    return space if validity
    human_target(player, computer_board, validity)
  end

  def validated_space?(computer_board, space) 
    if !computer_board.space_exists?(space)
      puts "\nThat space does not exist. Try again.".colorize(:red)
      return false
    end
    if computer_board.fired_on?(space)
      puts "\nYou have already fired on this space!".colorize(:red)
      return false
    end
    return true
  end

  def render_board(player, board)
    puts dash_board.draw(board).colorize(:blue)
  end

  def player_firing(obj = nil)
    if player.shot_count <= computer.shot_count 
      obj = {"player" => player, 
             "enemy"  => computer, 
             "board"  => computer_board} 
    else 
      obj = {"player" => computer, 
             "enemy"  => player,
             "board"  => player_board}  
    end
    if obj['player'] == player 
      puts "\nYour turn!!".colorize(:blue)
      puts "++++++++++++++++++\n".colorize(:blue)
    elsif obj['player'] == computer 
      puts "\n Computer's turn!!".colorize(:red)
      puts "++++++++++++++++++\n".colorize(:red)
    end
    obj
  end
end
