require_relative 'require'
require './lib/player'

class PlayerTest < Minitest::Test 
  def setup
    @player = Player.new 
  end

  def test_existence 
    assert @player
    assert_instance_of Player, @player
  end

  def test_shot_count
    assert_equal 0, @player.shot_count
  end
end

