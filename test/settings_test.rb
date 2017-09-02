require_relative 'require'
require './lib/settings'

class SettingsTest < Minitest::Test
  def test_instance
    assert_instance_of Settings, Settings.new    
  end
end
