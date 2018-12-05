class Oystercard

  attr_accessor :balance
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @cardstate = false
  end

  def top_up(value)
    exceed = (balance + value - LIMIT)
    balance + value > LIMIT ? raise("top up exceeds maximum balance(£#{LIMIT}) by #{exceed}") : @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @cardstate
  end

  def touch_in
   balance < MINIMUM ? raise("Balance less than (£#{Oystercard::MINIMUM}) Please top up") : @cardstate = true
  end

  def touch_out
    @cardstate = false
  end

end
