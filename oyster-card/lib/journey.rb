class Journey

  attr_accessor :journey


  def initialize
    @journey = {entry_station: nil, exit_station: nil}
  end

 def check_fair
   if @journey[entry_station] == nil || @journey[exit_station] == nil
      return 6
    else
      return 2
   end
 end
end
