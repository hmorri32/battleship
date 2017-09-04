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
    four.build_board.map do |row|
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
    assert_equal 'A4', four.get_space('A4').position
    assert_instance_of Space, four.get_space('A4')
    
    assert_equal 'B2', four.get_space('B2').position
    assert_instance_of Space, four.get_space('B2')
    
    assert_equal 'C3', four.get_space('C3').position
    assert_instance_of Space, four.get_space('C3')

    assert_equal 'D1', four.get_space('D1').position
    assert_instance_of Space, four.get_space('D1')
  end

  def test_space_exists
    refute four.space_exists?('Z4')
    assert four.space_exists?('A4')
  end

  def test_neighbor?
    assert four.neighbors?('A1', 'B1')
    assert four.neighbors?('A1', 'A2')
    
    refute four.neighbors?('A1', 'C2')
    refute four.neighbors?('B1', 'A2')
  end

  def test_same_row?
    assert four.same_row?('A1', 'A2')
    assert four.same_row?('B1', 'B2')

    refute four.same_row?('A1', 'B2')
    refute four.same_row?('A1', 'B2')
    refute four.same_row?('A1', 'B2')
  end

  def test_same_column? 
    assert four.same_column?('A1', 'B1')
    assert four.same_column?('A2', 'B2')

    refute four.same_column?('A1', 'B2')
    refute four.same_column?('A1', 'B3')
    refute four.same_column?('A1', 'B4')
  end

  def test_span_horizontally
    assert_equal 4, four.span_horizontally('A1', 'A4')
    assert_equal 3, four.span_horizontally('A1', 'A3')
    assert_equal 2, four.span_horizontally('A1', 'A2')
    assert_equal 1, four.span_horizontally('A1', 'A1')
  end

  def test_span_vertically
    assert_equal 4, four.span_vertically('A1', 'D1')
    assert_equal 3, four.span_vertically('A1', 'C1')
    assert_equal 2, four.span_vertically('A1', 'B1')
    assert_equal 1, four.span_vertically('A1', 'A1')
  end

  def test_space_full_default_false
    refute four.space_full?('A1')
  end

  def test_can_fill_space 
    refute four.space_full?('A1')
    four.fill_space('A1')
    assert four.space_full?('A1')
  end

  def test_can_find_all_spots_flat 
    expected1 = ['A1', 'A2', 'A3', 'A4']
    expected2 = ['A1', 'A2', 'A3']
    expected3 = ['C2', 'C3', 'C4']
    
    assert_equal expected1, four.all_spaces_flat('A1', 'A4')
    assert_equal expected2, four.all_spaces_flat('A1', 'A3')
    assert_equal expected3, four.all_spaces_flat('C2', 'C4')
  end

  def test_can_find_all_spaces_vertical 
    expected1 = ["A3", "B3", "C3", "D3"]
    expected2 = ["B1", "C1"]
    expected3 = ["A4", "B4", "C4"]

    assert_equal expected1, four.all_spaces_vertical('A3', 'D3')
    assert_equal expected2, four.all_spaces_vertical('B1', 'C1')
    assert_equal expected3, four.all_spaces_vertical('A4', 'C4')
  end

  def test_can_fill_sequential_spaces 
    four.fill_spaces('A1', 'A4')

    assert four.space_full?('A1')
    assert four.space_full?('A2')
    assert four.space_full?('A3')
    assert four.space_full?('A4')

    four.fill_spaces('A1', 'D1')

    assert four.space_full?('A1')
    assert four.space_full?('B1')
    assert four.space_full?('C1')
    assert four.space_full?('D1')
  end

  def test_fired_on?
    refute four.fired_on?('A1')    
  end

  def test_fired_on_method 
    refute four.fired_on?('A1')
    four.fire_on('A1')
    assert four.fired_on?('A1')
  end

  def test_hit? 
    refute four.hit?('A4')
    
    four.fill_spaces('A1', 'A4')
    four.fire_on('A4')

    assert four.hit?('A4')
  end

  def test_miss?
    refute four.miss?('A4')
    refute four.fired_on?('A4')
    
    four.fill_spaces('A1', 'B1')
    four.fire_on('A4')

    assert four.miss?('A4')
    assert four.fired_on?('A4')
  end
end