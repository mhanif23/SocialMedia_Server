require_relative "../../models/hastag.rb"

describe Hashtag do
  before :each do
    @client = double
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

  describe 'get trending' do
    it 'should exec query' do
      query = "select Hastags.hastag, COUNT(id_hastag) as total_hastag FROM Hastag_contracts inner join Hastags on id_hastag = Hastags.id WHERE createdAt > (NOW() - INTERVAL 1 DAY)  GROUP BY hastag ORDER BY count(id_hastag) DESC LIMIT 5"
      expect(@client).to receive(:query).with(query)
    end
  end
end