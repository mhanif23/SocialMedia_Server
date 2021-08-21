require_relative "../../models/hastag.rb"

describe Hashtag do
  before :each do
    @client = double
    allow(@client).to receive(:close)
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end
  describe 'initialize' do
    before :each do
      @hashtag_data = {name: '#liverpool'}
      @hashtag = Hashtag.new(
        name: @hashtag_data[:name]
      )
    end
    it 'should give name attribute' do
      expect(@hashtag.name).to be(@hashtag_data[:name])
    end
  end
end