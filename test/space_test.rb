require_relative 'require'
require './lib/space'

class SpaceTest < Minitest::Test 
  attr_accessor :space

  def setup
    @space = Space.new('B4')
  end

  def test_space_unoccupied 
    refute space.occupied
  end

  def test_space_not_fired_on 
    refute space.fired_on
  end

  def test_space_coordinates
    assert_equal 'B4', space.coordinates
  end
end