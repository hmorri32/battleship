class Settings
  def initialize
    @beginner     = {'size' => 4,  'ships' => [2,3]}
    @intermediate = {'size' => 8,  'ships' => [2,3,4]}
    @advanced     = {'size' => 12, 'ships' => [2,3,4,5]}
  end
end

# beginner, intermediate, advanced
# beginner     => size 4  => ships 2, 3
# intermediate => size 8  => ships 2, 3, 4
# advanced     => size 12 => ships 2, 3, 4, 5