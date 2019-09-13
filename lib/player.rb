class Player
  attr_accessor :name, :buildings, :streets, :resources

  def initialize(name)
    @name = name
    @buildings = []
    @streets = []
    @resources = { brick: 0, lumber: 0, wool: 0, grain: 0, ore: 0 }
  end
end
