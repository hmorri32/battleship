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

  def test_small_ship_doesnt_fall_off_map 
    assert small_ship_stays_on_map?(@board, 'A3', 'A4')
    assert small_ship_stays_on_map?(@board, 'A4', 'B4')
    assert small_ship_stays_on_map?(@board, 'C2', 'D2')

    refute small_ship_stays_on_map?(@board, 'A4', 'A5')
    refute small_ship_stays_on_map?(@board, 'D4', 'E4')
  end
end