class Ship
  attr_accessor :length,
                :damage, 
                :start,
                :end
                
  def initialize(length)
    @length = length
    @damage = 0 
    @start  = nil
    @end    = nil
  end
end