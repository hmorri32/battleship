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

  def place(bow, stern)
    @bow   = bow
    @stern = stern
  end
end