class Journey

  attr_accessor :journey

  def initialize
    @journey = {entry_station: nil, exit_station: nil}
  end

  def check_fare(card)
    if @journey[:entry_station] == nil || @journey[:exit_station] == nil
      (card.journey_history) << (@journey)
      return 6
    else
      (card.journey_history) << (@journey)
      return 1
    end
  end

end
