require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }

  it 'new cards have default balance 0' do
    expect(card.balance).to eq(0)
  end

  describe '#top_up' do
    it 'adds .top_up value to balance' do
      value = 50
      expect { card.top_up(value) }.to change { card.balance }.by(value)
    end
    it 'raises error when topping-up balance past maximum' do
      maximum_amount = (Oystercard::MAX_BALANCE) # shows calling constants outside of class (will eq 90)
      card.top_up(maximum_amount)
      expect { card.top_up(1) }.to raise_error "top up exceeds maximum balance (#{maximum_amount})"
    end

  end

  describe '#deduct' do
    it 'deducts value from balance' do
      card.top_up(Oystercard::MAX_BALANCE)
      value = 50
      expect { card.deduct(value) }.to change { card.balance }.by(-value)
    end
  end

end
