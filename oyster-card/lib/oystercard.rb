class Oystercard

  attr_accessor :balance, :entry_station
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @entry_station = nil
    # @out_station = nil
  end

  def top_up(value)
    exceed = (balance + value - LIMIT)
    balance + value > LIMIT ? raise("top up exceeds maximum balance(£#{LIMIT}) by #{exceed}") : @balance += value
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(station)
    balance < MINIMUM ? raise("Balance less than (£#{MINIMUM}) Please top up") : @entry_station = station
  end

  def touch_out
    deduct(MINIMUM)
    @entry_station = nil
  end

  private
  def deduct(value)
    @balance -= value
  end

end
