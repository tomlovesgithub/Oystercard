require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  context "initally" do
    it 'has default balance 0' do
      expect(card.balance).to eq(0)
    end
    it 'is not in journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#top_up' do
    it 'adds .top_up value to balance' do
      value = 50
      expect { card.top_up(value) }.to change { card.balance }.by(value)
    end
    it 'raises error when topping-up balance past maximum' do
      maximum_amount = (Oystercard::MAX_BALANCE) # shows calling constants outside of class (will eq 90)
      card.top_up(maximum_amount)
      value = rand(1..10)
      balance_by = (card.balance + value - (Oystercard::MAX_BALANCE))
      expect { card.top_up(value) }.to raise_error "top up exceeds maximum balance(#{Oystercard::MAX_BALANCE}) by #{balance_by}"
    end
  end

  describe '#deduct' do
    it 'deducts value from balance' do
      card.top_up(Oystercard::MAX_BALANCE)
      value = 50
      expect { card.deduct(value) }.to change { card.balance }.by(-value)
    end
  end

  describe '#injourney' do
    it ' true after touch_in' do
      expect { card.touch_in }.to change { card.in_journey? }.from(false).to(true)
    end
  end

  describe '#injourney' do
    it 'false after touch_in then touch_out' do
      card.touch_in
      expect { card.touch_out }.to change { card.in_journey? }.from(true).to(false)
    end
  end

end
