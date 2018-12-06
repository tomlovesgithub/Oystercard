class Station

  attr_accessor :zone
  attr_reader :name

  def initialize(name, zone = "undefined")
    @name = name
    @zone = zone
  end

end
