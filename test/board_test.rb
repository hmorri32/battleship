require_relative 'require'
require './lib/board'

class BoardTest < Minitest::Test
  attr_accessor :four,
                :eight,
                :twelve

  def setup
    @four   = Board.new(4)
    @eight  = Board.new(8)
    @twelve = Board.new(12)
  end

  def test_board_size
    assert_equal 4,  four.size
    assert_equal 8,  eight.size
    assert_equal 12, twelve.size
  end

  def test_row_method 
    expected = ["A", "B", "C", "D"]
    assert_equal expected, four.rows
  end

  def test_column_method 
    expected = ['1', '2', '3', '4']
    assert_equal expected, four.columns
  end

  def test_space_name_arr_method 
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

    assert_equal expected, four.space_name_arr
  end

  def test_space_hash_builds_new_spaces
    tiny_board = Board.new(2)
    space      = tiny_board.space_hash['A1']

    assert_instance_of Space, space
  end

  def test_can_build_spaces_display
    expected = [["A1", "A2", "A3", "A4"],
                ["B1", "B2", "B3", "B4"],
                ["C1", "C2", "C3", "C4"],
                ["D1", "D2", "D3", "D4"]]
    actual   = format_grid

    assert_equal expected, actual
  end

  def format_grid
    four.build_game_grid.map do |stuff|
      stuff.map {|stuff| stuff.keys[0]}
    end
  end


end