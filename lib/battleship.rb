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

  def initialize(board_size, ships)
    @player         = Player.new(ships)
    @computer       = Computer.new(ships)
    @computer_board = Board.new(board_size)
    @player_board   = Board.new(board_size)
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
    computer.ships.each do |ship|
      spaces = computer.position(computer_board, ship)
      spaces = valid_computer_placement?(computer_board, ship, spaces)
      computer.place_ship(computer_board, ship, spaces[0], spaces[1])
    end
    puts Messages.computer_has_placed_ships.colorize(:red)
  end

  def p_ships 
    player.ships.each do |ship|
      spaces = validate_input(ship)
      player.place_ship(player_board, ship, spaces[0], spaces[1])
      puts "\n You have placed your #{ship.length} unit ship at #{spaces[0]} #{spaces[1]}".colorize(:blue)
    end
  end

  def game_flow 
    color = ''
    # TODO refactor all this junk
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
    end
    game_over 
  end

  def game_over 
    end_time = Time.new
    end_min  = end_time.min - @time.min 
    end_sec  = 0

    if end_time.sec > @time.sec 
      end_sec = end_time.sec - @time.sec
    else 
      end_sec = @time.sec - end_time.sec 
    end

    if player.loser? 
      puts 'You lose. Sucks to suck, mate.'.colorize(:red)
      puts "This game lasted #{end_min} minutes and #{end_sec} seconds."
    else 
      puts 'You smoked the competition, matey'.colorize(:blue)
      puts "This game lasted #{end_min} minutes and #{end_sec} seconds."
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