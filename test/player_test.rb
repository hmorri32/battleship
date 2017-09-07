require_relative 'require'
require './lib/player'

class PlayerTest < Minitest::Test 
  attr_accessor :inter,
                :playa,
                :board, 
                :ship1,
                :ship2

  def setup
    @inter = Player.new([2,3,4])
    @playa = Player.new([2,3])
    @ship1 = playa.ships[0]
    @ship2 = playa.ships[1]
    @board = Board.new(4)
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
    assert_equal 2, playa.ships.length 
  end

  def test_playa_can_shoot 
    assert_equal 0, playa.shot_count
    
    playa.shoot(board, 'A1')

    assert_equal 1, playa.shot_count
  end

  def test_ships_built_on_instantiation 
    assert_instance_of Ship, playa.ships[0]
    assert_instance_of Ship, playa.ships[1]
  end

  def test_playa_can_place_ship 
    @ship1 = playa.ships[0]
    @ship2 = playa.ships[1]

    playa.place_ship(board, ship1, 'A1', 'A2')
    playa.place_ship(board, ship2, 'B1', 'B3')

    assert_equal 'A1', ship1.bow
    assert_equal 'A2', ship1.stern

    assert_equal 'B1', ship2.bow
    assert_equal 'B3', ship2.stern
  end

  def test_places_ships_are_on_board 
    ship1 = playa.ships[0]
    
    playa.place_ship(board, ship1, 'B1', 'D1')
    playa.place_ship(board, ship1, 'A1', 'A4')

    assert board.space_full?('B1')
    assert board.space_full?('C1')
    assert board.space_full?('D1')

    assert board.space_full?('A1')
    assert board.space_full?('A2')
    assert board.space_full?('A3')
    assert board.space_full?('A4')
  end

  def test_player_can_attack 
    refute board.fired_on?('A1')
    refute board.fired_on?('A2')
    refute board.fired_on?('B1')
    refute board.fired_on?('D4')

    playa.shoot(board, 'A1')
    playa.shoot(board, 'A2')
    playa.shoot(board, 'B1')
    playa.shoot(board, 'D4')

    assert board.fired_on?('A1')
    assert board.fired_on?('A2')
    assert board.fired_on?('B1')
    assert board.fired_on?('D4')    
  end

  def test_players_ships_can_be_sunk 
    refute ship1.sunk?
    refute ship2.sunk?

    ship1.strike
    ship1.strike

    ship2.strike
    ship2.strike
    ship2.strike

    assert ship1.sunk?
    assert ship2.sunk?
  end

  def test_player_can_be_a_loser 
    refute ship1.sunk?
    refute ship2.sunk?
    refute playa.loser?

    ship1.strike
    ship1.strike

    ship2.strike
    ship2.strike
    ship2.strike

    assert ship1.sunk?
    assert ship2.sunk?
    assert playa.loser?
  end
end

