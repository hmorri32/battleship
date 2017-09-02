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
    four.build_game_grid.map do |row|
      row.map {|column| column.keys[0]}
    end
  end

  def test_north_neighbor
    refute four.north?('A1')
    refute four.north?('A2')
    assert four.north?('B1')
  end

  def test_south_neighbor
    refute four.south?('D1')
    refute four.south?('D2')
    assert four.south?('C2')
  end
  
  def test_east_neighbor
    refute four.east?('A4')
    refute four.east?('B4')
    assert four.east?('B2')
  end
  
  def test_west_neighbor
    refute four.west?('A1')
    refute four.west?('B1')
    refute four.west?('C1')
    assert four.west?('A2')
  end

  def test_get_north_neighbor
    assert_equal 'A1', four.north_coordinates('B1')
  end

  def test_get_south_neighbor
    assert_equal 'B1', four.south_coordinates('A1')    
  end

  def test_get_east_neighbor
    assert_equal 'A2', four.east_coordinates('A1')
  end

  def test_get_west_neighbor
    assert_equal 'A2', four.west_coordinates('A3')
  end

  def test_all_neighbors 
    expected_A2 = ["B2", "A3", "A1"]
    expected_B2 = ["A2", "C2", "B3", "B1"]
    expected_C2 = ["B2", "D2", "C3", "C1"]
    expected_D2 = ["C2", "D3", "D1"]

    assert_equal expected_A2, four.neighbors('A2')
    assert_equal expected_B2, four.neighbors('B2')
    assert_equal expected_C2, four.neighbors('C2')
    assert_equal expected_D2, four.neighbors('D2')
  end

  def test_get_space 
    assert_equal 'A4', four.get_space('A4').coordinates
    assert_instance_of Space, four.get_space('A4')
    
    assert_equal 'B2', four.get_space('B2').coordinates
    assert_instance_of Space, four.get_space('B2')
    
    assert_equal 'C3', four.get_space('C3').coordinates
    assert_instance_of Space, four.get_space('C3')

    assert_equal 'D1', four.get_space('D1').coordinates
    assert_instance_of Space, four.get_space('D1')
  end

  def test_space_exists
    refute four.space_exists?('Z4')
    assert four.space_exists?('A4')
  end
end