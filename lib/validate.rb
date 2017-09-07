require_relative 'ship'
require_relative 'player'
require_relative 'board'

module Validate
  def valid_space?(board, space)
    board.space_exists?(space)
  end

  def two_valid_spaces?(board, space_1, space_2)
    board.space_exists?(space_1) && board.space_exists?(space_2)
  end

  def no_diagonals?(space_1, space_2)
    space_1[0] == space_2[0] || space_1[1] == space_2[1]
  end

  def valid_length?(board, ship, space_1, space_2)
    if board.same_row?(space_1, space_2)
      ship.length == board.span_horizontally(space_1, space_2)
    else
      ship.length == board.span_vertically(space_1, space_2)
    end
  end

  def no_overlap?(board, ship, bow, stern)
    board.get_spaces(bow, stern).none? do |space|
      board.space_full?(space)
    end
  end

  def game_over?(one, two)
    one.loser? || two.loser?
  end

  def validate_input(ship)
    validity = false 
    until validity 
      puts Messages.place_ship(ship) + "\n"
      answer   = gets.chomp.upcase.split(" ")
      validity = space_valid?(player_board, ship, answer)
    end
    return answer
  end

  def space_valid?(board, ship, answer)
    validity  = false
    input     = valid_gets?(board, ship, answer)
    direction = valid_direction?(answer)      if input
    length    = length?(board, ship, answer)  if direction
    validity  = overlap?(board, ship, answer) if length
    return validity
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
end