require_relative 'require'
require './lib/ship'

class ShipTest < Minitest::Test
  attr_accessor :cool_boat,
                :shippy,
                :mc_ship_face

  def setup
    @cool_boat    = Ship.new(4)
    @shippy       = Ship.new(8)
    @mc_ship_face = Ship.new(12)
  end

  def test_ship_initialized_size
    assert_equal 4,  cool_boat.length
    assert_equal 8,  shippy.length
    assert_equal 12, mc_ship_face.length
  end

  def test_ship_damage
    assert_equal 0, cool_boat.damage
  end

  def test_ship_initialized_start
    assert_equal nil, cool_boat.start
  end

  def test_ship_initialized_end
    assert_equal nil, cool_boat.end
  end
end