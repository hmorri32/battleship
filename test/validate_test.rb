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
end