require_relative 'board'
require_relative 'ship'
require_relative 'player'
require_relative 'computer'
require_relative 'validate'
require_relative 'BattleShip'
require_relative 'messages'
require 'colorize'


class GameRunner 
  def self.welcome
    puts Messages.welcome
    answer = gets.chomp.downcase 
    case 
    when answer == 'p' || answer == 'play'
      game = BattleShip.new
    when answer == 'i' || answer == 'instructions'
      puts Messages.instructions
      welcome
    when answer == 'q' || answer == 'quit'
      puts "sayonara".colorize(:red)
      exit
    else 
      puts "\nPlease select either 'p', 'i', or 'q'!".colorize(:red)
      welcome
    end
  end
  welcome
end