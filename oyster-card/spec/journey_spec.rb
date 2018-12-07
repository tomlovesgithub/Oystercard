require 'journey'

describe Journey do

  let(:journey){ Journey.new}

  it 'should have entry and exit of nil on start' do
    expect(journey.journey[:entry_station]).to be(nil)
    expect(journey.journey[:exit_station]).to be(nil)
  end

  it "should respond to check_fair" do
    expect(journey).to respond_to(:check_fair)
  end
end
