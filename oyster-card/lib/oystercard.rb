class Oystercard

  require_relative 'journey'

  attr_accessor :balance, :active_journey, :journey_history
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @active_journey = Journey.new
    @balance = 0
    @journey_history = []
  end

  def top_up(value)
    exceed = (balance + value - LIMIT)
    balance + value > LIMIT ? raise("top up exceeds maximum balance(£#{LIMIT}) by #{exceed}") : @balance += value
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(station)
    if balance < MINIMUM
     raise("Balance less than (£#{MINIMUM}) Please top up")
   elsif active_journey.journey[:entry_station] != (nil)
     deduct(active_journey.check_fare(self))
   else
     active_journey.journey[:entry_station] = (station.name)
   end
  end

  def touch_out(station)
    active_journey.journey[:exit_station] = (station.name)
    deduct(active_journey.check_fare(self))
    @active_journey = Journey.new
  end

  private
  
  def deduct(value)
    @balance -= value
  end

end
