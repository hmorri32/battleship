class Space
  attr_accessor :coordinates, 
                :occupied,
                :fired_on
  
  def initialize(coordinates)
    @coordinates = coordinates
    @occupied    = false
    @fired_on    = false
  end
end