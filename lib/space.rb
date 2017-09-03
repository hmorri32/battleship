class Space
  attr_accessor :position, 
                :full,
                :fired_on
  
  def initialize(position)
    @position = position
    @full     = false
    @fired_on = false
  end
end