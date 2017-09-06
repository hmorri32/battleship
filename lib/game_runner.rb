require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'computer'
require_relative 'validate'
require_relative 'BattleShip'
require_relative 'messages'
require          'colorize'


class GameRunner 
  # TODO FIGURE OUT HOW LEVELS WORK
  def self.welcome
    puts Messages.welcome
    answer = gets.chomp.downcase 
    case
    when answer == 'p' || answer == 'play'
      select_difficulty
    when answer == 'i' || answer == 'instructions'
      puts Messages.instructions.colorize(:blue)
      welcome
    when answer == 'q' || answer == 'quit'
      puts "sayonara".colorize(:red)
      exit
    else 
      puts Messages.invalid_input.colorize(:red)
      welcome
    end
  end

  def self.select_difficulty 
    puts Messages.difficulty.colorize(:blue)
    answer = gets.chomp.downcase 
    case
    when answer == 'b' || answer == 'beginner'
      game = BattleShip.new(4, [2,3])
    when answer == 'i' || answer == 'intermediate'
      game = BattleShip.new(8, [2,3,4])
    else 
      puts Messages.invalid_difficulty.colorize(:red)
      select_difficulty
    end
  end
  welcome
end