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
      maximum_amount = (Oystercard::LIMIT) # shows calling constants outside of class (will eq 90)
      card.top_up(maximum_amount)
      value = rand(1..10)
      balance_by = (card.balance + value - (Oystercard::LIMIT))
      expect { card.top_up(value) }.to raise_error "top up exceeds maximum balance(£#{Oystercard::LIMIT}) by #{balance_by}"
    end
  end

  # private method cannot be tested
  # describe '#deduct' do
  #   it 'deducts value from balance' do
  #     # card.top_up(Oystercard::LIMIT)
  #     # value = rand(1..90)
  #     # expect { card.deduct(value) }.to change { card.balance }.by(-value)
  #   end
  # end

  describe '#injourney' do
    card = Oystercard.new
    card.top_up(Oystercard::LIMIT)
    it ' true after touch_in' do
      station = double(:Station, station_name: "big_london_station")
      expect { card.touch_in(station) }.to change { card.in_journey? }.from(false).to(true)
    end

    it 'false after touch_in then touch_out' do
      station = double(:Station, station_name: "big_london_station")
      card.touch_in(station)
      expect { card.touch_out }.to change { card.in_journey? }.from(true).to(false)
    end
  end

  describe '#touch_in' do
    card = Oystercard.new
    let(:station) { double(:Station, station_name: "big_london_station") }
    it " won't allow to touch_in if balance lower than minimum" do
      expect { card.touch_in(station) }.to raise_error "Balance less than (£#{Oystercard::MINIMUM}) Please top up"
    end

    it " Remembers touch_in station" do
      card.top_up(Oystercard::LIMIT)
      expect { card.touch_in(station.station_name) }.to change { card.in_station }.from(nil).to("big_london_station")
    end
  end

  describe '#touch_out' do
    it " will change the balance by the minimum fare" do
      station = double(:Station, station_name: "big_london_station") 
      card.top_up(Oystercard::LIMIT)
      card.touch_in(station)
      expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MINIMUM)
    end
  end

end
