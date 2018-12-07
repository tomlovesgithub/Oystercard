require 'journey'
require 'oystercard'
require 'station'


describe Journey do


  let(:journey) {Journey.new}

  let(:card) { Oystercard.new }
  before { card.top_up(Oystercard::LIMIT)}
  let(:station) { double :station, name: 'big_london_station'}

  it 'should have entry and exit of nil on start' do
    expect(journey.journey[:entry_station]).to be(nil)
    expect(journey.journey[:exit_station]).to be(nil)
  end

  it "should respond to check_fare" do
    expect(journey).to respond_to(:check_fare)
  end

  it " #touch_in should remember touch_in station" do
    expect { card.touch_in(station) }.to change { card.active_journey.journey[:entry_station] }.from(nil).to(station.name)
  end

  it ' #touch_out should change after make active_journey values nil again' do
    card.touch_in(station)
    card.touch_out(station)
    expect(card.active_journey.journey[:exit_station]).to eq(nil)
  end


end
