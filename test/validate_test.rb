require_relative 'require'
require './lib/validate'

class ValidateTest < Minitest::Test
  include Validate 
  attr_reader :board

  def setup 
    @board = Board.new(4)
  end

  def test_dis
    ultra_chill = "ultra chill"
    assert_equal 'ultra chill', ultra_chill
  end

  def test_valid_space
    assert valid_space?(@board, 'A4')
    assert valid_space?(@board, 'A1')
    assert valid_space?(@board, 'A2')
    assert valid_space?(@board, 'A3')

    refute valid_space?(@board, 'Cool')
    refute valid_space?(@board, 'A6')
    refute valid_space?(@board, 'Z1')
    refute valid_space?(@board, 'suh')
  end

  def test_valid_spaces
    assert two_valid_spaces?(@board, 'A1', 'A2')
    assert two_valid_spaces?(@board, 'A1', 'D2')

    refute two_valid_spaces?(@board, 'A1', 'Z2')
    refute two_valid_spaces?(@board, 'A1', 'M2')
  end

  def test_no_diagonals 
    assert no_diagonals?("A2", "B2")
    assert no_diagonals?("A2", "A3")
    assert no_diagonals?("C1", "C4")

    refute no_diagonals?("A2", "B4")
    refute no_diagonals?("A1", "B2")
    refute no_diagonals?("A5", "B2")
  end

  def test_valid_length 
    cool_ship = Ship.new(2)
    threez    = Ship.new(3)
    four_foot = Ship.new(4)

    assert valid_length?(@board, cool_ship, 'A1', 'A2')
    assert valid_length?(@board, threez, 'A1', 'A3')
    assert valid_length?(@board, four_foot, 'A1', 'A4')
    
    refute valid_length?(@board, cool_ship, 'A1', 'A4')
    refute valid_length?(@board, threez, 'A1', 'A4')
    refute valid_length?(@board, four_foot, 'A1', 'A3')
  end
end