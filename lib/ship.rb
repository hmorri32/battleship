class Ship
  attr_accessor :length,
                :damage, 
                :bow,
                :stern
                
  def initialize(length)
    @length = length
    @damage = 0 
    @bow    = nil
    @stern  = nil
  end
end