require_relative 'require'
require './lib/dashboard'

class DashBoardTest < Minitest::Test 
  def setup
    @dash = DashBoard.new
    
  end
  
  def test_stuff 
    stuff = 'things'
    assert_equal stuff, 'things'
  end
end