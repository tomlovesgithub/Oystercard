class Oystercard

  attr_accessor :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(value)
    balance + value > MAX_BALANCE ? raise("top up exceeds maximum balance (#{Oystercard::MAX_BALANCE})") : @balance += value
  end

  def deduct(value)
    @balance -= value 
  end

end
