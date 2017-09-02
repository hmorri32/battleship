require_relative 'require'
require './lib/validate'

class ValidateTest < Minitest::Test
  def test_dis
    ultra_chill = "ultra chill"
    assert_equal 'ultra chill', ultra_chill
  end
end