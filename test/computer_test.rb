require_relative 'require'
require './lib/computer'
require './lib/board'
require './lib/ship'

class ComputerTest < Minitest::Test 
  attr_accessor :computer, 
                :board, 
                :shippy

  def setup
    @computer = Computer.new([2,3])
    @board    = Board.new(4)
    @shippy   = Ship.new(2)
  end

  def test_computer_playa_exists 
    assert computer 
    assert_instance_of Computer, computer
  end

  def test_random_space 
    assert_instance_of String, computer.random_space(board)
  end

  def test_choose_spaces
    assert_instance_of Array, computer.choose_spaces(board)
  end

  def test_empty_space
    assert_instance_of String, computer.empty_space(board)    
  end

  def test_position_flat 
    assert_equal 'A3', computer.position_flat(board, 'A1', 3)
    assert_equal 'B2', computer.position_flat(board, 'B1', 2)
  end

  def test_position_vertical
    assert_equal 'B1', computer.position_vertical(board, 'A1', 2)
    assert_equal 'D1', computer.position_vertical(board, 'A1', 4)
  end

  def test_shuffler 
    truthy   = true 
    shuffler = computer.shuffler 

    if shuffler == true
      assert truthy
    end
  end

  def test_rando_flat_vertical
    assert_instance_of String, computer.rando_flat_vertical(board, 'A2', 3)
    assert_instance_of String, computer.rando_flat_vertical(board, 'A1', 2)
    assert_instance_of String, computer.rando_flat_vertical(board, 'B2', 2)
  end

  def test_position 
    assert_instance_of Array, computer.position(board, shippy)      
  end
  
  def test_not_attacked 
    assert_instance_of String, computer.not_attacked(board)        
  end
end