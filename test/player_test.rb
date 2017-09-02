require_relative 'require'
require './lib/player'

class PlayerTest < Minitest::Test 
  attr_accessor :player, :playa
  def setup
    @player = Player.new 
    @playa  = Player.new([2,3])
  end

  def test_existence 
    assert player
    assert_instance_of Player, player
  end

  def test_shot_count
    assert_equal 0, player.shot_count
  end

  def test_default_ships 
    assert_nil player.ship_arr
    assert_equal [2,3], playa.ship_arr
  end

  def test_total_ship_count 
    playa.ship_builder
    assert_equal 2, playa.total_ships 
  end

  def test_playa_can_shoot 
    assert_equal 0, playa.shot_count
    
    playa.shoot

    assert_equal 1, playa.shot_count
  end

  def test_playa_can_place_ship 
    
  end
end

