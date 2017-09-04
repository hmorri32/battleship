require_relative 'require'
require './lib/computer'

class ComputerTest < Minitest::Test 
  attr_accessor :computer
  def setup
    @computer = Computer.new([2,3])
  end

  def test_computer_playa_exists 
    assert computer 
    assert_instance_of Computer, computer
  end
end