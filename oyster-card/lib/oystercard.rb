class Oystercard

  attr_accessor :balance, :entry_station, :journey_history
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
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
    balance < MINIMUM ? raise("Balance less than (£#{MINIMUM}) Please top up") : @entry_station = station.name
  end

  def touch_out(station)
    deduct(MINIMUM)
    @exit_station = station.name
    journey_history.push({in:@entry_station, out:@exit_station})
    @entry_station = nil
    @exit_station = nil

  end

  private
  def deduct(value)
    @balance -= value
  end

end
