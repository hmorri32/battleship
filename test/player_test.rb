require_relative 'require'
require './lib/player'

class PlayerTest < Minitest::Test 
  attr_accessor :inter, :playa

  def setup
    @inter = Player.new([2,3,4])
    @playa = Player.new([2,3])
  end

  def test_existence 
    assert playa
    assert_instance_of Player, playa
  end

  def test_shot_count
    assert_equal 0, playa.shot_count
  end

  def test_default_ships 
    assert_equal [2,3], playa.ship_arr
  end

  def test_total_ship_count 
    assert_equal 2, playa.total_ships 
  end

  def test_playa_can_shoot 
    assert_equal 0, playa.shot_count
    
    playa.shoot

    assert_equal 1, playa.shot_count
  end

  def test_ships_built_on_instantiation 
    assert_instance_of Ship, playa.ships[0]
    assert_instance_of Ship, playa.ships[1]
  end

  def test_playa_can_place_ship 
    ship1 = playa.ships[0]
    ship2 = playa.ships[1]

    playa.place_ship(ship1, 'A1', 'A2')
    playa.place_ship(ship2, 'B1', 'B3')

    assert_equal 'A1', ship1.bow
    assert_equal 'A2', ship1.stern

    assert_equal 'B1', ship2.bow
    assert_equal 'B3', ship2.stern
  end
end

