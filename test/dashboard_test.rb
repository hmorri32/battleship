require_relative 'require'
require './lib/dashboard'
require './lib/board'

class DashBoardTest < Minitest::Test 
  attr_accessor :dash

  def setup
    @dash  = DashBoard.new
    @board = Board.new(4)
  end
  
  def test_stuff 
    stuff = 'things'
    assert_equal stuff, 'things'
  end

  def test_dash_exists 
    assert dash 
    assert_instance_of DashBoard, dash
  end

  def test_border_method 
    assert_equal '==============', dash.border
  end

  def test_row_formatter 
    assert_equal "M H   M", dash.format_row(['M', 'H', '', 'M'])
    assert_equal "M M M M", dash.format_row(['M', 'M', 'M', 'M'])
    assert_equal "H H H H", dash.format_row(['H', 'H', 'H', 'H'])
    assert_equal "       ", dash.format_row(['', '', '', ''])
    assert_equal "H      ", dash.format_row(['H', '', '', ''])
  end

  def test_grid 
    expected = "==============\n. 1 2\nA H H\nB H  \n=============="

    assert_equal expected, dash.grid(2, [['A', 'H', 'H'], ['B', 'H', '']])
  end

  def test_rows
    expected = [["A", "", "", "", ""], 
                ["B", "", "", "", ""], 
                ["C", "", "", "", ""], 
                ["D", "", "", "", ""]]
    actual = dash.rows(@board)

    assert_equal actual, expected
  end

  def test_render 
    expected = "==============\n. 1 2 3 4\nA        \nB        \nC        \nD        \n=============="

    assert_equal expected, dash.draw(@board)
  end

  def test_hit? 
    refute dash.hit?(@board, 'A1')

    @board.fill_space('A1')
    @board.fire_on('A1')

    assert dash.hit?(@board, 'A1')
  end

  def test_miss?
    refute dash.miss?(@board, 'A1')

    @board.fire_on('A1')

    assert dash.miss?(@board, 'A1')
  end

  def test_empty?
    assert dash.empty?(@board, 'A1')

    @board.fire_on('A1')

    refute dash.empty?(@board, 'A1')
  end
end