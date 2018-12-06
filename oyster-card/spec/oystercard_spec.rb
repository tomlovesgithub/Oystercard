require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new }
  let(:station) { double :station, station_name: 'big_london_station'}

  context "Brand new Oystercard" do

    it 'has default balance 0' do
      expect(card.balance).to eq(0)
    end
    it 'is not in journey' do
      expect(card).not_to be_in_journey
    end

    describe '#top_up' do
      let(:maximum_amount) {Oystercard::LIMIT}

      it 'adds .top_up value to balance' do
        expect { card.top_up(maximum_amount) }.to change { card.balance }.by(maximum_amount)
      end

      it 'raises error when topping-up balance past maximum' do
        expect { card.top_up(maximum_amount + 1) }.to raise_error "top up exceeds maximum balance(£#{Oystercard::LIMIT}) by #{1}"
      end
    end

    describe '#touch_in' do

      it " won't allow to touch_in if balance lower than minimum" do
        expect { card.touch_in(station) }.to raise_error "Balance less than (£#{Oystercard::MINIMUM}) Please top up"
      end

    end

    describe '#touch_out' do
      it " will change the balance by the minimum fare" do
        card.top_up(Oystercard::LIMIT)
        card.touch_in(station)
        expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MINIMUM)
      end
    end

  end

  context 'Oystercard is topped up with max value' do

    before { card.top_up(Oystercard::LIMIT)}

    it ' #injourney should be true after touch_in' do
      expect { card.touch_in(station) }.to change { card.in_journey? }.from(false).to(true)
    end

    it " #touch_in should remembers touch_in station" do
      expect { card.touch_in(station.station_name) }.to change { card.entry_station }.from(nil).to("big_london_station")
    end

    it ' #in_journey should false after touch_in then touch_out' do
      card.touch_in(station)
      expect { card.touch_out }.to change { card.in_journey? }.from(true).to(false)
    end
  end

end
